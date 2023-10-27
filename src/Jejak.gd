extends Sprite2D


func _ready():
	DialogueManager.passed_title.connect(_passed_title)
	set_visible(false)


func _passed_title(_title):
	
	if _title == "flower_returned":
		print(_title)
		set_visible(true)
