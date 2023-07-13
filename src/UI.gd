extends CanvasLayer


# Called when the node enters the scene tree for the first time.
@export var Balloon: PackedScene
#@export var SmallBalloon: PackedScene


var title: String
var dialogue_resource: DialogueResource


func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	


func show_dialogue(key: String) -> void:
	assert(dialogue_resource != null, "\"dialogue_resource\" property needs a to point to a DialogueResource.")
	
	#var is_small_window: bool = ProjectSettings.get_setting("display/window/size/viewport_width") < 400
	#var balloon: Node = (SmallBalloon if is_small_window else Balloon).instantiate()
	var balloon: Node = Balloon.instantiate()
	add_child(balloon)
	balloon.start(dialogue_resource, key)


### Signals


func _on_dialogue_ended(_resource: DialogueResource):
	await get_tree().create_timer(0.4).timeout
	$VirtualJoystick.set_visible(true)



func _on_talk_button_pressed():
	await get_tree().create_timer(0.4).timeout
	$VirtualJoystick.set_visible(false)
	$TalkButton.set_visible(false)
	show_dialogue(title)
