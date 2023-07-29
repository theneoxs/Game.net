extends Node

@onready var black_screen = $CanvasLayer/BlackScreen

var is_stop_glitch = false
var next_scr = ""

var is_process_change_scr = false

signal changing_scene
var is_changing_scene = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_black_screen(delta)

func process_black_screen(delta):
	if black_screen.modulate.a >= 0.05 and is_process_change_scr == false:
		black_screen.modulate.a = lerp(black_screen.modulate.a, -0.5, delta)
	elif is_process_change_scr == true:
		black_screen.modulate.a = lerp(black_screen.modulate.a, 1.5, delta)
		if black_screen.modulate.a >= 0.95:
			black_screen.modulate.a = 1
			if is_changing_scene == false:
				changing_scene.emit()
				is_changing_scene = true
	else:
		black_screen.modulate.a = 0

func to_black():
	is_process_change_scr = true

func from_black():
	is_process_change_scr = false
	is_changing_scene = false

func set_visible_black_screen(vis):
	black_screen.visible = vis

func set_next_scr(new_next_scr, is_start = true):
	next_scr = new_next_scr
	if is_start:
		to_black()


func ready_screen():
	next_scr = ""
	set_visible_black_screen(true)
	black_screen.modulate.a = 1
	from_black()
