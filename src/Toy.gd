extends Sprite2D

@export var dialogue_resource: DialogueResource

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)


func _on_dialogue_ended(_resource: DialogueResource):
	
	if _resource == dialogue_resource:
		GameState.flower_status = true
		GameState.flower_has = true
		queue_free()

