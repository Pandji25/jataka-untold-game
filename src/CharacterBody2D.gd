extends CharacterBody2D

@export var speed : float = 300
const facing = ["right", "right_down", "down", "left_down", "left", "left_up", "up", "right_up"]

#var move_vector = Vector2.ZERO
var last_facing_direction = ""

var spawn

func _ready():
	
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
	spawn = PlayerVariables.spawn_point
	if spawn != null:
		set_position(spawn)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right",  "ui_up", "ui_down")
	velocity = direction.normalized() * speed
	
	move_and_slide()
	
	
	# gets eight directions from joystick (0-7)
	if not direction == Vector2.ZERO:
		var i = wrapi(int(snapped(direction.angle(), PI / 4) / (PI / 4)), 0, 8)
		last_facing_direction = facing[i]#
		$AnimationPlayer.play("walk_" + last_facing_direction)
	else:
		$AnimationPlayer.stop()
		
		match last_facing_direction:
			"right":
				$Sprite2D.set_frame(6)
				$Sprite2D.flip_h = false
			"right_down":
				$Sprite2D.set_frame(3)
				$Sprite2D.flip_h = false
			"down":
				$Sprite2D.set_frame(0)
			"left_down":
				$Sprite2D.set_frame(3)
				$Sprite2D.flip_h = true
			"left":
				$Sprite2D.set_frame(6)
				$Sprite2D.flip_h = true
			"left_up":
				$Sprite2D.set_frame(9)
				$Sprite2D.flip_h = true
			"up":
				$Sprite2D.set_frame(12)
			"right_up":
				$Sprite2D.set_frame(9)
				$Sprite2D.flip_h = false
			

func _on_area_2d_area_entered(area):
	if area.is_in_group("NPC"):
		var ui = get_node_or_null("../UI")
		
		ui.dialogue_resource = area.dialogue_resource
		ui.title = area.title
		
		GameState.interacting_object = area
		#print(GameState.interacting_object)
		
		if ui.about_to_start_auto_dialogue:
			return
		ui.get_node("TalkButton").set_disabled(false)
		ui.get_node("TalkButton").set_visible(true)

func _on_area_2d_area_exited(area):
	if area.is_in_group("NPC"):
		var ui = get_node_or_null("../UI")
		
		ui.get_node("TalkButton").set_disabled(true)
		ui.get_node("TalkButton").set_visible(false)


func _on_dialogue_ended(_resource: DialogueResource):
	$Area2D.set_monitoring(false)

	await get_tree().create_timer(0.5).timeout

	$Area2D.set_monitoring(true)
