extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.passed_title.connect(_on_title_passed)



func _on_title_passed(_title):
	if _title == "vine_chopped" or _title == "noise":
		queue_free()
