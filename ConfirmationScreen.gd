extends Control

@onready var header = $Plate/Header
@onready var main_text = $Plate/Text
@onready var decline_btn = $Plate/HBoxContainer/Decline
@onready var confirm_btn = $Plate/HBoxContainer/Confirm
#Режим кнопок: 0 - все, 1 - подтверждение, 2 - отказ
var mode = 0

signal confirm
signal decline

# Called when the node enters the scene tree for the first time.
func _ready():
	use_mode(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_header(text : String):
	header.text = text

func set_main_text(text : String):
	main_text.text = text

func set_data(header_text : String, main_text : String, new_mode : int = 0):
	set_header(header_text)
	set_main_text(main_text)
	use_mode(new_mode)

func use_mode(new_mode : int):
	mode = new_mode
	if mode == 1:
		decline_btn.visible = false
		confirm_btn.visible = true
	elif mode == 2:
		decline_btn.visible = true
		confirm_btn.visible = false
	else:
		decline_btn.visible = true
		confirm_btn.visible = true


func _on_decline_pressed():
	_on_btn_click()
	decline.emit()
	queue_free()


func _on_confirm_pressed():
	_on_btn_click()
	confirm.emit()
	queue_free()

func _on_start_mouse_entered():
	Global.play_btn_in()

func _on_btn_click():
	Global.play_btn_click()
