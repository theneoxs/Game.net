extends Control

func _ready():
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)
	$TimeHeader/TimeStamp.text = Global.calc_complete_time(Global.time1 + Global.time2 +Global.time3 +Global.time4 +Global.time5 )


func _on_next_pressed():
	_on_btn_click()
	#Перемещение на уровень
	Global.set_next_scr("res://GUI/main_menu.tscn")

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)

func _on_start_mouse_entered():
	Global.play_btn_in()

func _on_btn_click():
	Global.play_btn_click()
