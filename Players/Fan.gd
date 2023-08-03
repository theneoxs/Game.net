extends RigidBody2D

@onready var area_fan = $Area2D
@onready var left_block = $TileBlockLeft
@onready var right_block = $TileBlockRight
var g_hero = null

func _ready():
	pass

func _process(delta):
	pass

var selected = false
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
		linear_velocity.y = 0
		if Input.is_action_pressed("m_rotate_r"):
			area_fan.rotation_degrees = 0
			left_block.visible = false
			right_block.visible = true
		elif Input.is_action_pressed("m_rotate_l"):
			area_fan.rotation_degrees = -90
			left_block.visible = true
			right_block.visible = false
	if g_hero != null:
		var g_pos = g_hero.global_position
		var vec_move = Vector2(g_pos.x - self.global_position.x, g_pos.y - global_position.y)
		g_hero.appent_to_conn_vector(vec_move.normalized()*math_calc_vector_to(vec_move.length()))

func math_calc_vector_to(x):
	if x <= 440:
		return (-10.0+1.0/exp((x-900)/200))
	else:
		return 0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			set_coll_layer_and_mask(3)

func _on_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click_l"):
		selected = true
		linear_velocity.y = 0
		linear_velocity.x = 0
		set_coll_layer_and_mask(2)

func set_coll_layer_and_mask(num):
	collision_layer = num
	collision_mask = num



func _on_area_2d_area_entered(area):
	if area.get_name() == "PlayerAreaTrigger":
		g_hero = area.get_parent()


func _on_area_2d_area_exited(area):
	if area.get_name() == "PlayerAreaTrigger":
		g_hero = null
