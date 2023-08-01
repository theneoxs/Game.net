extends RigidBody2D

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
			rotation += 0.1
		elif Input.is_action_pressed("m_rotate_l"):
			rotation -= 0.1

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false

func _on_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click_l"):
		selected = true
		linear_velocity.y = 0
		linear_velocity.x = 0
