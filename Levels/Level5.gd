extends Control

var block = load("res://Players/Block.tscn")
var board = load("res://Players/Board.tscn")
var fan = load("res://Players/Fan.tscn")
@onready var spawnpoint = $Player/Point_spawn
var time_start = 0.0
var pick_item = 0

@onready var rope = $AREAROPE/CollisionShape2D/Rope
# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = Time.get_unix_time_from_system()
	Global.in_game = true
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/TimeLabel.text = Global.calc_complete_time(Time.get_unix_time_from_system() - time_start)

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)


func _on_choose_mode_choosing_item(num):
	pick_item = num
	if num == 0:
		var spawn_block = Global.block.instantiate()
		spawn_block.position = spawnpoint.global_position
		add_child(spawn_block)
	
	elif num == 1:
		var spawn_block = Global.board.instantiate()
		spawn_block.position = spawnpoint.global_position
		add_child(spawn_block)
		
	elif num == 2:
		var spawn_block = Global.fan.instantiate()
		spawn_block.position = spawnpoint.global_position
		add_child(spawn_block)
			
	elif num == 3:
		var spawn_block = Global.spring.instantiate()
		spawn_block.position = spawnpoint.global_position
		add_child(spawn_block)
		
	elif  num == 4:
		var spawn_block = Global.dot.instantiate()
		$Player.add_child(spawn_block)
		spawn_block.position = spawnpoint.position
		rope.toclick = true
		rope.spawnpoint = spawnpoint


func _respawn_player():
	Global.accepted_items[pick_item] = false
	get_tree().reload_current_scene()

func _on_exit_area_body_entered(body):
	Global.time5 = Time.get_unix_time_from_system() - time_start
