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
	if num == 2:
		$Area2D.collision_layer = 0
		$Area2D.collision_mask = 0
	else:
		$Area2D.collision_layer = 5
		$Area2D.collision_mask = 5


func _on_area_2d_area_entered(area):
	if area.get_name() == "PlayerAreaTrigger":
		area.get_parent().press_to_spring()
