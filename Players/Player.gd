extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_tree: AnimationTree = $AnimationTree

var idle_sprite
var walk_sprite
var jump_sprite
var death_sprite

var is_death = false

func _ready():
	animation_tree.active = true
	idle_sprite = $Idle
	walk_sprite = $Walk
	jump_sprite = $Jump
	death_sprite = $Death
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
	if is_death:
		set_anim_tree(false, false, false, true)
	elif is_on_floor():
		if velocity == Vector2.ZERO:
			set_anim_tree(true, false, false)
		else:
			set_anim_tree(false, true, false)
	else:
		set_anim_tree(false, false, true)
	
	if velocity.x > 0 and !is_death:
		flip_anim(false)
	elif velocity.x < 0 and !is_death:
		flip_anim(true)

#Установка анимаций: idle, move и jump
func set_anim_tree(is_idle : bool, is_moving : bool, is_jumpong : bool, is_death : bool = false):
	animation_tree["parameters/conditions/idle"] = is_idle
	animation_tree["parameters/conditions/is_moving"] = is_moving
	animation_tree["parameters/conditions/is_jumping"] = is_jumpong
	animation_tree["parameters/conditions/is_death"] = is_death
	
	idle_sprite.visible = is_idle 
	walk_sprite.visible = is_moving 
	jump_sprite.visible = is_jumpong 
	death_sprite.visible = is_death 
	

func flip_anim(is_left):
	idle_sprite.flip_h = is_left
	walk_sprite.flip_h = is_left
	jump_sprite.flip_h = is_left
	walk_sprite.offset.x = -10 if is_left else 10
