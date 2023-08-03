extends Control

@onready var items = [$MainBlock/HBoxContainer/Box,$MainBlock/HBoxContainer/Plank, 
$MainBlock/HBoxContainer/Rope, $MainBlock/HBoxContainer/Fan, $MainBlock/HBoxContainer/Spring]

@onready var main_block = $MainBlock
@onready var black_block = $ColorRect

var cum_time = 0.0
var speed_anim = 15

## Number of choosing item
signal choosing_item(num : int)

var num_item = 0

var first_run = true
var is_started = false
var is_fin = false
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	black_block.modulate.a = 0
	for i in range(len(Global.accepted_items)):
		items[i].get_node("Button").disabled = Global.accepted_items[i]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if first_run and !is_fin:
		black_block.modulate.a = lerp(black_block.modulate.a, 0.9, delta)
		if black_block.modulate.a > 0.8:
			black_block.modulate.a = 0.8
			first_run = false
			is_started = true
	elif first_run and is_fin:
		black_block.modulate.a = lerp(black_block.modulate.a, -0.5, delta)
		if black_block.modulate.a < 0.1:
			black_block.modulate.a = 0
			choosing_item.emit(num_item)
			queue_free()
	if is_started:
		cum_time += delta
		main_block.position = main_block.position.lerp(Vector2(0,0), speed_anim*speed_coef(cum_time)*delta)
		if main_block.position.x < 2:
			main_block.position.x = 0
			is_started = false
			cum_time = 0.0
	elif !is_started and is_fin:
		cum_time += delta
		main_block.position = main_block.position.lerp(Vector2(-1600,0), speed_anim*speed_coef(cum_time)*delta)
		if main_block.position.x < -900:
			first_run = true
		if main_block.position.x < -1598:
			main_block.position.x = -1600


func _on_cube_btn_pressed():
	chose_item(0)


func _on_plank_btn_pressed():
	chose_item(1)


func _on_rope_btn_pressed():
	chose_item(2)


func _on_fan_btn_pressed():
	chose_item(3)


func _on_spring_btn_pressed():
	chose_item(4)

func chose_item(num):
	for i in range(len(Global.accepted_items)):
		items[i].get_node("Button").disabled = true
	num_item = num
	Global.accepted_items[num] = true
	is_fin = true

func speed_coef(x):
	return -0.1+1.0/(1.0+exp(5*pow(1.5*x-1.5, 2)))+pow(x,0.5)/4
