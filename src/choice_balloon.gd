extends CanvasLayer


@onready var balloon = $Balloon
@onready var character_label = $Balloon/VBoxContainer/MarginContainer2/CharLabel
@onready var dialogue_label = $Balloon/VBoxContainer/MarginContainer/DialogueLabel
@onready var responses_menu = $VBoxContainer/ResponseList
@onready var response_template = $ResponseTemplate
@onready var next_button = $NextButton
@onready var response_lable = $ResponseTemplate/ResponseText
@onready var responses_container = $VBoxContainer
@onready var menu_lable = $VBoxContainer/Label

var resource: DialogueResource

var temporary_game_states: Array = []

var is_waiting_for_input: bool = false

var portraits: Dictionary = {}

## The current line
var dialogue_line: DialogueLine:
	set(next_dialogue_line):
		if not next_dialogue_line:
			queue_free()
			return
		
		is_waiting_for_input = false
		
		# Remove any previous responses
		for child in responses_menu.get_children():
			responses_menu.remove_child(child)
			child.queue_free()
		
		dialogue_line = next_dialogue_line
		
		# Dim all characters except the one talking
		for portrait in portraits:
			if portrait == dialogue_line.character.to_lower():
				portraits[portrait].modulate = Color.WHITE
			else:
				portraits[portrait].modulate = Color("757575")
		
		character_label.visible = not dialogue_line.character.is_empty()
		character_label.text = dialogue_line.character
	
		dialogue_label.modulate.a = 0
		dialogue_label.dialogue_line = dialogue_line
		
		# Show any responses we have
		menu_lable.modulate.a = 0
		responses_menu.modulate.a = 0
		if dialogue_line.responses.size() > 0:
			for response in dialogue_line.responses:
				# Duplicate the template so we can grab the fonts, sizing, etc
				var item: Button = response_template.duplicate(0)
				item.name = "Response%d" % responses_menu.get_child_count()
#				if not response.is_allowed:
#					item.name = String(item.name) + "Disallowed"
#					item.modulate.a = 0.4
				#var item_text = response_lable.duplicate(0)
				#item_text.name = "ResponseText"
				#item_text.text = response.text
				item.get_child(0).text = response.text
				item.show()
				responses_menu.add_child(item)
				#item.add_child(item_text)
				print(item.get_children())
				#set_response(item, dialogue_line.responses[response].next_id)
				
		
		dialogue_label.modulate.a = 1
		dialogue_label.type_out()
		next_button.set_visible(false)
		await dialogue_label.finished_typing
		
		# Wait for input
		if dialogue_line.responses.size() > 0:
			await get_tree().create_timer(1.5).timeout
			balloon.modulate.a = 0
			menu_lable.modulate.a = 1
			responses_menu.modulate.a = 1
			var tween = create_tween()
			var center_pos_y = responses_container.position.y
			tween.tween_property(responses_container, "position:y", center_pos_y, 0.5).from(-500).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			set_response()
			print(center_pos_y)
		elif dialogue_line.time != null:
			var time = dialogue_line.dialogue.length() * 0.02 if dialogue_line.time == "auto" else dialogue_line.time.to_float()
			await get_tree().create_timer(time).timeout
			next(dialogue_line.next_id)
		else:
			
			is_waiting_for_input = true
			next_button.set_visible(true)
			#balloon.focus_mode = Control.FOCUS_ALL
			#balloon.grab_focus()
	get:
		return dialogue_line


func _ready():
	response_template.hide()
	menu_lable.modulate.a = 0
	
	print(get_viewport().size.x)
	
	Engine.get_singleton("DialogueManager").mutated.connect(_on_mutated)
	dialogue_label.finished_typing.connect(_on_typing_finished)


func _unhandled_input(_event: InputEvent) -> void:
	# Only the balloon is allowed to handle input while it's showing
	get_viewport().set_input_as_handled()


## Start some dialogue
func start(dialogue_resource: DialogueResource, title: String, extra_game_states: Array = []) -> void:
	temporary_game_states = extra_game_states + [self]
	is_waiting_for_input = false
	resource = dialogue_resource
	#next_button.set_visible(false)
	self.dialogue_line = await resource.get_next_dialogue_line(title, temporary_game_states)

## Go to the next line
func next(next_id: String) -> void:
	#next_button.set_visible(false)
	self.dialogue_line = await resource.get_next_dialogue_line(next_id, temporary_game_states)


func add_portrait(character: String, slot: int = 0) -> void:
	var slot_marker: Marker2D = get_node("CenterPos/Slot%d" % slot)
	
	if slot_marker.get_child_count() > 0: return
	
	# Instantiate the character
	var portrait = load("res://src/%s.tscn" % character).instantiate()
	slot_marker.add_child(portrait)
	
	portraits[character] = portrait
	
	var tween_modifier: int
	
	if slot > 0 :
		tween_modifier = 1
	elif slot == 0 :
		tween_modifier = -1
	
	print(slot_marker.position.x)
	
	# Character appears
	var tween: Tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_ease(Tween.EASE_OUT)
	tween.tween_property(portrait, "position:x", 0.0, 0.5).from(tween_modifier*500).set_trans(Tween.TRANS_SINE)
	#await get_tree().create_timer(0.8).timeout


func call_portrait(character: String, method: String) -> void:
	portraits[character].call(method)


func remove_portrait(character: String) -> void:
	var portrait = portraits[character]
	
	# Character leaves
	var tween: Tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(portrait, "position:y", 1000.0, 0.5).from(0.0)
	await get_tree().create_timer(0.8).timeout
	portraits.erase(character)
	portrait.queue_free()


func _on_mutated(_mutation: Dictionary) -> void:
	is_waiting_for_input = false
	dialogue_label.modulate.a = 0.0


func set_response():
	var items = get_responses()
	for i in items.size():
		var item: Button = items[i]
		
		item.pressed.connect(_on_response_button_pressed.bind(item))

func get_responses() -> Array:
	var items: Array = []
	for child in responses_menu.get_children():
		#if "Disallowed" in child.name: continue
		items.append(child)
		
	return items

func _on_response_button_pressed(item):
	menu_lable.modulate.a = 0
	responses_menu.modulate.a = 0.0
	balloon.modulate.a = 1
	next(dialogue_line.responses[item.get_index()].next_id)

func _on_next_button_pressed():
	if not is_waiting_for_input: return
	if dialogue_line.responses.size() > 0: return

	# When there are no response options the balloon itself is the clickable thing	
	get_viewport().set_input_as_handled()
	
	next(dialogue_line.next_id)

func _on_typing_finished():
#	if !is_waiting_for_input:
#		next_button.set_visible(true)
	pass
