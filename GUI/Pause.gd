extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


func _on_decline_pressed():
	_on_btn_click()
	back()


func _on_confirm_pressed():
	_on_btn_click()
	Global.in_game = false
	get_tree().change_scene_to_file("res://GUI/main_menu.tscn")
	back()

func back():
	get_tree().paused = false
	queue_free()

func _on_start_mouse_entered():
	Global.play_btn_in()

func _on_btn_click():
	Global.play_btn_click()
