extends Sprite2D


@onready var toy_interact: Area2D = $ToyInteract


func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)


func _on_dialogue_ended(_resource: DialogueResource):
	if _resource == toy_interact.dialogue_resource:
		queue_free()
