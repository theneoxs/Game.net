extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_tree: AnimationTree = $AnimationTree

var idle_sprite
var walk_sprite
var jump_sprite

func _ready():
	animation_tree.active = true
	idle_sprite = $Idle
	walk_sprite = $Walk
	jump_sprite = $Jump
	idle_sprite.show()

func _process(delta):
	update_animation_parameters()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("m_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("m_left", "m_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func update_animation_parameters():
	if velocity == Vector2.ZERO:
		idle_sprite.show()
		walk_sprite.hide()
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		idle_sprite.hide()
		walk_sprite.show()
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true
	
	if(Input.is_action_just_pressed("m_jump")):
		idle_sprite.hide()
		walk_sprite.hide()
		jump_sprite.show()
		animation_tree["parameters/conditions/is_jumping"] = true
	else:
		jump_sprite.hide()
		animation_tree["parameters/conditions/is_jumping"] = false
