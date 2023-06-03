extends Area2D

var entered = false
@export var map_scene = "res://src/node_2d1.tscn"
@export var next_spawn_position = Vector2()


func _on_body_entered(body:CharacterBody2D):
	PlayerVariables.spawn_point = next_spawn_position
	get_tree().change_scene_to_file(map_scene)
	print(str(PlayerVariables.spawn_point))
	
	

#func _on_body_exited(body:CharacterBody2D):
	#entered = false

#func _process(delta):
	#if entered == true:                 # forest map
		#get_tree().change_scene_to_file("res://node_2d1.tscn")
