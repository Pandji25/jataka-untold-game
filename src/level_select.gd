@tool
extends Control


@export var scene_path = "res://src/node_2d.tscn"
@export var chapter_title : String
@export var chapter_preview : Texture2D
@export_multiline var chapter_description : String
@export var locked : bool = false

@onready var ch_title = get_node("VBoxContainer2/VBoxContainer/ChapterTitle")
@onready var ch_texture = get_node("VBoxContainer2/VBoxContainer/VBoxContainer/ChapterImage")
@onready var ch_desc = get_node("VBoxContainer2/VBoxContainer/VBoxContainer/ChapterDescription")
@onready var play_button = get_node("VBoxContainer2/PlayButton")

func _ready():
	if not Engine.is_editor_hint():
		ch_title.set_text(chapter_title)
		ch_texture.set_texture(chapter_preview)
		ch_desc.set_text(chapter_description)
		_locked(locked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		ch_title.set_text(chapter_title)
		ch_texture.set_texture(chapter_preview)
		ch_desc.set_text(chapter_description)
		_locked(locked)

func _locked(toggle: bool):
	if toggle:
		ch_texture.set_modulate(Color(0.29, 0.29, 0.29, 1))
		play_button.set_disabled(true)
	else:
		ch_texture.set_modulate(Color(1, 1, 1, 1))
		play_button.set_disabled(false)


func _on_play_button_pressed():
	if not Engine.is_editor_hint():
		get_tree().change_scene_to_file(scene_path)
		print("play")
