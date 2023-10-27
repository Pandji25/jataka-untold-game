extends Area2D

@export var dialogue_resource: DialogueResource
@export var title: String
@export var snake: StaticBody2D
@export var is_empty: bool = true

var is_carried: bool = false

func _ready():
	snake.snake_initialized.connect(my_func)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.passed_title.connect(_on_title_passed)
	GameState.repellant_status_changed.connect(_on_repellant_status_changed)
	
	#print(snake.interact_collision)
	#await snake.snake_initialized
	
	if is_empty:
		$Sprite2D.set_visible(false)
		snake.appear(true)
	else:
		$Sprite2D.set_visible(true)
		snake.appear(false)
		

func _on_dialogue_ended(_resource: DialogueResource):
	#title = GameState.repellant_status
	pass

func _on_title_passed(_title):
	if _title == "encounter":
		title = "taking"

func _on_repellant_status_changed(_object, _status, _is_carrying):
	if self == _object:
		if _is_carrying:
			is_empty = true
			$Sprite2D.set_visible(false)
			snake.appear(true)
			
		else:
			is_empty = false
			$Sprite2D.set_visible(true)
			snake.appear(false)
			
	title = _status
	print(str(self) + ":")
	print("is_empty is %s" % is_empty)
	print("title is %s" % _status)
	print("----")
	
#	if value == "take":
#		$Sprite2D.set_visible(true)
#	elif value == "place":
#		if GameState.is_carrying_repellant:
#			return
#		else:
#			$Sprite2D.set_visible(false)
#	
func my_func(value):
	print(value)
