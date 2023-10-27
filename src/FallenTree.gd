extends StaticBody2D



func _ready():
	DialogueManager.passed_title.connect(_passed_title)


func _passed_title(_title):
	
	if _title == "tree_chopped" or _title == "flower_returned":
		print(_title)
		queue_free()
