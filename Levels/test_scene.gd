extends Control

var block = load("res://Players/Block.tscn")
var board = load("res://Players/Board.tscn")
@onready var spawnpoint = $Point_spawn

func _ready():
	Global.in_game = true
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)


func _process(delta):
	pass

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)

func _on_choose_mode_choosing_item(num):
	if num == 0:
		var spawn_block = block.instantiate()
		spawn_block.position = spawnpoint.position
		add_child(spawn_block)
	
	elif num == 1:
		var spawn_block = board.instantiate()
		spawn_block.position = spawnpoint.position
		add_child(spawn_block)


func _respawn_player():
	$Player.position = $Respawn.position

	
