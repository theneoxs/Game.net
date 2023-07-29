extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)

func _on_back_pressed():
	Global.set_next_scr("res://GUI/main_menu.tscn")

func _on_confirm_pressed():
	var confirm_scr = preload("res://GUI/confirmation_screen.tscn").instantiate()
	add_child(confirm_scr)
	confirm_scr.set_data("Сохранение", "Нечего сохранять. Сохранить?")
	confirm_scr.confirm.connect(get_signal_confirm)

func get_signal_confirm():
	var final_scr = preload("res://GUI/confirmation_screen.tscn").instantiate()
	add_child(final_scr)
	final_scr.set_data("Завершено", "Не сохранение успешно завершено", 1)

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)
