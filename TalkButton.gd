extends Control

# Called when the node enters the scene tree for the first time.
@export var Balloon: PackedScene
#@export var SmallBalloon: PackedScene
#@export var title: String = "start"
@export var dialogue_resource: DialogueResource

var title: String


func show_dialogue(key: String) -> void:
	assert(dialogue_resource != null, "\"dialogue_resource\" property needs a to point to a DialogueResource.")
	
	#var is_small_window: bool = ProjectSettings.get_setting("display/window/size/viewport_width") < 400
	#var balloon: Node = (SmallBalloon if is_small_window else Balloon).instantiate()
	var balloon: Node = Balloon.instantiate()
	add_child(balloon)
	balloon.start(dialogue_resource, key)

func _on_texture_button_pressed():
	await get_tree().create_timer(0.4).timeout
	show_dialogue(title)
