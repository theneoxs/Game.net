extends Area2D

var level_scenes = ["res://Levels/Level1.tscn", "res://Levels/Level2.tscn"]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.get_name() == "Player":
		print("exit")
		get_tree().change_scene_to_file(level_scenes[0])
	
	
