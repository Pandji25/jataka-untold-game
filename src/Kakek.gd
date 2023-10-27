extends StaticBody2D

@export var dialogue_resource: DialogueResource
@export var title: String

signal activate_dialogue(resource, title, wait)

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(_resource: DialogueResource):
	if _resource != $Area2D.dialogue_resource:
		return
	if GameState.flower_gave == "Bapak Tua" and !GameState.loud_noise_heard:
		activate_dialogue.emit(dialogue_resource, title, 3)
