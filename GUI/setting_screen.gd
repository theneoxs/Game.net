extends Control

@onready var master_volume = $VolumeMaster
@onready var sfx_volume = $VolumeSFX
@onready var music_volume = $VolumeMusic

var rect = Vector2(1440, 900)
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)
	master_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))*100.0
	sfx_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))*100.0
	music_volume.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))*100.0

func _on_back_pressed():
	_on_btn_click()
	Global.set_next_scr("res://GUI/main_menu.tscn")

func _on_confirm_pressed():
	_on_btn_click()
	var confirm_scr = preload("res://GUI/confirmation_screen.tscn").instantiate()
	add_child(confirm_scr)
	confirm_scr.set_data("Сохранение", "Сохраняются настройки звука. Сохранить?")
	confirm_scr.confirm.connect(get_signal_confirm)

func get_signal_confirm():
	var final_scr = preload("res://GUI/confirmation_screen.tscn").instantiate()
	add_child(final_scr)
	final_scr.set_data("Завершено", "Настройки звука сохранены", 1)
	Global.save_settings()

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)

func _on_start_mouse_entered():
	Global.play_btn_in()

func _on_btn_click():
	Global.play_btn_click()



func _on_volume_master_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(master_volume.value/100.0))
	Global._settings["sound"]["Master"] = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))


func _on_volume_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx_volume.value/100.0))
	Global._settings["sound"]["SFX"] = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))


func _on_volume_music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_volume.value/100.0))
	Global._settings["sound"]["Music"] = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
