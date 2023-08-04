extends Node

@onready var black_screen = $CanvasLayer/BlackScreen
@onready var dead_text = $CanvasLayer/Dead_text

var block = load("res://Players/Block.tscn")
var board = load("res://Players/Board.tscn")
var fan = load("res://Players/Fan.tscn")
var spring = load("res://Players/Spring.tscn")
var dot = load("res://LevelObjects/dot.tscn")

var time1 = 0.0
var time2 = 0.0
var time3 = 0.0
var time4 = 0.0
var time5 = 0.0

var is_stop_glitch = false
var next_scr = ""

var is_process_change_scr = false

var accepted_items = [false,false,false,false,false]

signal changing_scene
var is_changing_scene = false

var in_game = false

var url_server = "http://theneoxs.pythonanywhere.com/denchik_check"

var settings_file = "user://Config.cfg"
var _config_file = ConfigFile.new()

var _settings = {
	"sound":
		{
			"Master":db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))),
			"SFX":db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))),
			"Music":db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
		},
	
}
func _ready():
	load_settings()

func clear_ststs():
	accepted_items = [false,false,false,false,false]
	time1 = 0.0
	time2 = 0.0
	time3 = 0.0
	time4 = 0.0
	time5 = 0.0

func calc_complete_time(timer_to_complete):
	return '%02d:%02d' % [(int(timer_to_complete)/60)%60, int(timer_to_complete)%60]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_black_screen(delta)
	
	if Input.is_action_just_pressed("btn_back") and in_game and !has_node("CanvasLayer/Pause"):
		$GUI_btn_esc.play()
		$CanvasLayer.add_child(load("res://GUI/pause.tscn").instantiate())

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
	$CanvasLayer/Dead_text.visible = false
	set_visible_black_screen(true)
	black_screen.modulate.a = 1
	from_black()


func ser_visible_dead_text(vis):
	dead_text.visible = vis

func play_btn_in():
	$GUI_btn_in.play()

func play_btn_click():
	$GUI_btn_click.play()

func play_btn_esc():
	$GUI_btn_esc.play()

var is_stopped = true

func play_main_menu():
	if is_stopped:
		$GUI_main_sound.play()
		is_stopped = false

func stop_main_menu():
	is_stopped = true
	$GUI_main_sound.stop()

func _on_gui_main_sound_finished():
	if !is_stopped:
		$GUI_main_sound.play()

func save_settings():
	for section in _settings.keys():
		print(section)
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
	var err = _config_file.save(settings_file)
	if err!= OK:
		print("failed saved settings")
		return []
	else:
		print("saved")

func load_settings():
	var err = _config_file.load(settings_file)
	var check_null = false
	if err != OK:
		print("failed load settings")
		return []
	for section in _settings.keys():
		for key in _settings[section]:
			if _config_file.get_value(section, key, null) != null:
				_settings[section][key] = _config_file.get_value(section, key, null)
			else:
				check_null = true
	if check_null:
		save_settings()
		print("resave")
	else:
		print("load")
	
	for action_name in _settings["sound"].keys():
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(action_name), linear_to_db(_settings["sound"][action_name]))

var count_rescued_friends = 0

func play_rescue_sound():
	$Rescue.play()

