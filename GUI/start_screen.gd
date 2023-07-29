extends Control

#Логотип
@onready var logo = $Logo
#Глитч-эффект
@onready var glitches = $Glitch
#Черный экран
@onready var black_screen = $BlackScreen

@onready var glitch_sound = $GlitchSound
@onready var glitch_sound_stop = $GlitchStop

#Номер шага в анимации
var change_step = 0
#Кумулятивное время (для отсчета исчезноваения логотипа)
var cumulative_time = 0
var is_fin = false
func _ready():
	glitches.visible = false
	black_screen.visible = false
	logo.modulate.a = 0

func _process(delta):
	if logo.modulate.a <= 0.9 and change_step == 0:
		logo.modulate.a = lerp(logo.modulate.a, 1.5, delta)
	elif logo.modulate.a > 0.9 and change_step == 0:
		glitches.visible = true
		glitch_sound.play()
		change_step = 1
		logo.modulate.a = 1

	if change_step == 1:
		cumulative_time += delta
		if cumulative_time >= 2.5 and is_fin == false:
			is_fin = true
			glitch_sound.stop()
			glitch_sound_stop.play()
			logo.modulate.a = 0
			black_screen.visible = true
			

func _on_change_timer_timeout():
	get_tree().change_scene_to_file("res://GUI/main_menu.tscn")

func _on_glitch_sound_finished():
	if is_fin == false:
		glitch_sound.play()
