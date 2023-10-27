extends Area2D

@export var image: Sprite2D


func _ready():
	image.set_visible(false)


func _on_body_entered(body):
	if body is CharacterBody2D:
		image.set_visible(true)


func _on_body_exited(body):
	if body is CharacterBody2D:
		image.set_visible(false)
