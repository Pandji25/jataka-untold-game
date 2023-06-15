extends Control


@onready var level_count = get_child_count()
@onready var levels = get_children()
var selection = 0
func _ready():
	print(level_count)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	'''
	clamp(selection,0,level_count-1)
	
	if Input.is_action_just_pressed("ui_right"):
		selection += 1
		selection = min(selection,level_count-1)
		levels[selection-1].set_visible(false)
		levels[selection].set_visible(true)
	if Input.is_action_just_pressed("ui_left"):
		selection -= 1
		selection = max(selection,0)
		levels[selection+1].set_visible(false)
		levels[selection].set_visible(true)
	'''
	
	#print(selection)
	pass




func _on_r_button_pressed():
	selection += 1
	selection = min(selection,level_count-1)
	levels[selection-1].set_visible(false)
	levels[selection].set_visible(true)
	print("right")


func _on_l_button_pressed():
	selection -= 1
	selection = max(selection,0)
	levels[selection+1].set_visible(false)
	levels[selection].set_visible(true)
	print("left")
