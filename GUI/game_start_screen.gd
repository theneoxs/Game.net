extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)


func _on_back_pressed():
	_on_btn_click()
	Global.set_next_scr("res://GUI/main_menu.tscn")

func _on_next_pressed():
	_on_btn_click()
	#Перемещение на уровень
	Global.set_next_scr("res://Levels/Level1.tscn")

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)

func _on_start_mouse_entered():
	Global.play_btn_in()

func _on_btn_click():
	Global.play_btn_click()
