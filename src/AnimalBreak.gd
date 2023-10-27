extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.passed_title.connect(_on_title_passed)
	set_visible(false)
	$Area2D.set_monitorable(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_title_passed(_title):
	
	if _title == "check":
		set_visible(true)
		$Area2D.set_monitorable(true)
