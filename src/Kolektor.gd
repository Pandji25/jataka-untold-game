extends StaticBody2D



func _ready():
	DialogueManager.passed_title.connect(_on_title_passed)
	set_visible(false)
	$CollisionShape2D.set_disabled(true)
	$Area2D.set_monitorable(false)


func _on_title_passed(_title):
	if _title == "toy_taken":
		set_visible(true)
		$CollisionShape2D.set_disabled(false)
		$Area2D.set_monitorable(true)
