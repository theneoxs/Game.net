extends Control

var is_change_scr = false

func _ready():
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)


func _on_start_pressed():
	Global.set_next_scr("res://GUI/game_start_screen.tscn")

func _on_settings_pressed():
	Global.set_next_scr("res://GUI/setting_screen.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_authors_pressed():
	Global.set_next_scr("res://GUI/author_screen.tscn")

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)
