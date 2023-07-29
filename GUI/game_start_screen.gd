extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)


func _on_back_pressed():
	Global.set_next_scr("res://GUI/main_menu.tscn")

func _on_next_pressed():
	#Перемещение на уровень
	pass # Replace with function body.

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)
