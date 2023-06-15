extends Control


@onready var menu_anim = get_node("AnimationPlayer")
@onready var mandala_anim = get_node("Intro/Play/Mandala/Circle")

func _ready():
	menu_anim.play("menu_intro")
	mandala_anim.play("rotate")

func _input(event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	menu_anim.play("transition")
	print("play")
