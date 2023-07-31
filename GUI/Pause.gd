extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


func _on_decline_pressed():
	back()


func _on_confirm_pressed():
	Global.in_game = false
	get_tree().change_scene_to_file("res://GUI/main_menu.tscn")
	back()

func back():
	get_tree().paused = false
	queue_free()
