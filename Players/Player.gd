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

func _physics_process(delta):
	update_animation_parameters()
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
	if is_on_floor():
		if velocity == Vector2.ZERO:
			set_anim_tree(true, false, false)
		else:
			set_anim_tree(false, true, false)
	else:
		set_anim_tree(false, false, true)
	
	if Input.is_action_just_pressed("m_right"):
		flip_anim(false)
	elif Input.is_action_just_pressed("m_left"):
		flip_anim(true)

#Установка анимаций: idle, move и jump
func set_anim_tree(is_idle : bool, is_moving : bool, is_jumpong : bool):
	animation_tree["parameters/conditions/idle"] = is_idle
	animation_tree["parameters/conditions/is_moving"] = is_moving
	animation_tree["parameters/conditions/is_jumping"] = is_jumpong
	
	idle_sprite.visible = is_idle 
	walk_sprite.visible = is_moving 
	jump_sprite.visible = is_jumpong 

func flip_anim(is_left):
	idle_sprite.flip_h = is_left
	walk_sprite.flip_h = is_left
	jump_sprite.flip_h = is_left
	walk_sprite.offset.x = -10 if is_left else 10



