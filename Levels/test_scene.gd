extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)
