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

var count_collision = 0

func _on_body_entered(body):
	if body.get_name() == "Player":
		count_collision += 1
		print(body, count_collision)
		if count_collision >= 6:
			queue_free()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			print("нажали на палку")
			selected = false

func _on_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click_l"):
		selected = true
		print("держим палку", selected)
		linear_velocity.y = 0
		linear_velocity.x = 0




