extends Area2D

var entered = false

func _on_body_entered(body:CharacterBody2D):
	entered = true

func _on_body_exited(body:CharacterBody2D):
	entered = false

func _process(delta):
	if entered == true:                 # village map
		get_tree().change_scene_to_file("res://node_2d.tscn")
