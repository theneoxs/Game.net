extends Control

var is_change_scr = false
@onready var main_text = $MainText

func _ready():
	Global.play_main_menu()
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	main_text.modulate.a = (1-(Vector2(mouse_pos.x - 800, mouse_pos.y - 450).length())/200.0) * 0.5

func _on_start_pressed():
	Global.set_next_scr("res://GUI/game_start_screen.tscn")
	_on_btn_click()

func _on_settings_pressed():
	Global.set_next_scr("res://GUI/setting_screen.tscn")
	_on_btn_click()

func _on_exit_pressed():
	_on_btn_click()
	get_tree().quit()

func _on_authors_pressed():
	Global.set_next_scr("res://GUI/author_screen.tscn")
	_on_btn_click()

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)


func _on_start_mouse_entered():
	Global.play_btn_in()

func _on_btn_click():
	Global.play_btn_click()


func _on_leaderboard_pressed():
	Global.set_next_scr("res://GUI/leaderboard.tscn")
	_on_btn_click()
