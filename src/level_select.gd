extends Control


@export var scene_path = "res://src/node_2d.tscn"
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	get_tree().change_scene_to_file(scene_path)
	print("play")
