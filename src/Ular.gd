extends StaticBody2D

@onready var interact_area = $InteractArea
@onready var interact_collision = $InteractArea/CollisionShape2D
@onready var physics_collision:CollisionShape2D = $CollisionShape2D

signal snake_initialized(value)

func _ready():
	
	DialogueManager.passed_title.connect(_on_title_passed)
	
	snake_initialized.emit("printed")

func appear(value: bool):
	set_visible(value)
	physics_collision.set_disabled(!value)
	interact_area.set_monitorable(value)


func _on_title_passed(_title):
	if _title == "snake":
		interact_area.title = "check"
