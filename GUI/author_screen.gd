extends Control

@onready var point1 = $Header/Point1
@onready var point2 = $Header2/Point1
@onready var point3 = $Header3/Point1
@onready var point4 = $HBoxContainer/Header2/Point1
@onready var point5 = $HBoxContainer/Header3/Point1
@onready var point6 = $HBoxContainer/Header4/Point1
@onready var point7 = $TextureRect/Point1
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	$Header.modulate.a = (1-(Vector2(mouse_pos.x - point1.global_position.x, mouse_pos.y - point1.global_position.y).length())/200.0) * 0.5
	$Header2.modulate.a = (1-(Vector2(mouse_pos.x - point2.global_position.x, mouse_pos.y - point2.global_position.y).length())/200.0) * 0.5
	$Header3.modulate.a = (1-(Vector2(mouse_pos.x - point3.global_position.x, mouse_pos.y - point3.global_position.y).length())/200.0) * 0.5
	$HBoxContainer/Header2.modulate.a = (1-(Vector2(mouse_pos.x - point4.global_position.x, mouse_pos.y - point4.global_position.y).length())/200.0) * 0.5
	$HBoxContainer/Header3.modulate.a = (1-(Vector2(mouse_pos.x - point5.global_position.x, mouse_pos.y - point5.global_position.y).length())/200.0) * 0.5
	$HBoxContainer/Header4.modulate.a = (1-(Vector2(mouse_pos.x - point6.global_position.x, mouse_pos.y - point6.global_position.y).length())/200.0) * 0.5
	$TextureRect.modulate.a = (1-(Vector2(mouse_pos.x - point7.global_position.x, mouse_pos.y - point7.global_position.y).length())/200.0) * 0.5

func _on_back_pressed():
	_on_btn_click()
	Global.set_next_scr("res://GUI/main_menu.tscn")

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)

func _on_start_mouse_entered():
	Global.play_btn_in()

func _on_btn_click():
	Global.play_btn_click()
