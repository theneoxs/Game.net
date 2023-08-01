extends Area2D

@export var next_scene : String

func _ready():
	pass


func _process(delta):
	pass


func _on_body_entered(body):
	if body.get_name() == "Player":
		print("exit")
		get_tree().change_scene_to_file(next_scene)
