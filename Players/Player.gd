extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var coyouteTime = 2.0

var conn_x = 0
var conn_y = 0
var reg_conn_const = 5
var reg_conn_const_y = 10
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_tree: AnimationTree = $AnimationTree

var idle_sprite
var walk_sprite
var jump_sprite
var death_sprite
var action_sprite

var onRope = false

var is_death = false
var anim_off = false
signal respawn_player

func _ready():
	animation_tree.active = true
	idle_sprite = $Idle
	walk_sprite = $Walk
	jump_sprite = $Jump
	death_sprite = $Death
	action_sprite = $Action
	idle_sprite.show()
	onRope = false


func _physics_process(delta):
	update_animation_parameters()
	if !is_death:
		if onRope:
			var Vdirection = Input.get_axis("m_up", "m_down")
			if Vdirection:
				velocity.y = Vdirection * SPEED
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)
		
		if not is_on_floor() and !onRope:
			velocity.y += gravity * delta
			
		# Handle Jump.
		if (Input.is_action_just_pressed("m_jump") and is_on_floor()) or (Input.is_action_just_pressed("m_jump") and coyouteTime >0):
			$SoundJump.play()
			velocity.y = JUMP_VELOCITY
			coyouteTime = 0

		var direction = Input.get_axis("m_left", "m_right")
		velocity.x = direction * SPEED + conn_x
#		if direction:
#			velocity.x = direction * SPEED
#		else:
#			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if conn_x - reg_conn_const > 0:
			conn_x -= reg_conn_const
			#velocity.x += conn_x - direction * SPEED
		else:
			conn_x = 0
		if conn_y > 0 and conn_y - reg_conn_const_y > reg_conn_const_y:
			conn_y -= reg_conn_const_y
		elif conn_y < 0 and conn_y + reg_conn_const_y < -reg_conn_const_y:
			conn_y += reg_conn_const_y
		else:
			conn_y = 0
		velocity.y += conn_y
	else:
		velocity.y += gravity * delta
		velocity.x = 0
		if Input.is_action_just_pressed("m_restart"):
			$SoundRebirth.play()
			_to_die(false)
			emit_signal("respawn_player")
			
		
	move_and_slide()

	if is_on_floor():
		coyouteTime = 2.0
	elif not is_on_floor():
		coyouteTime -=0.1

func press_to_spring():
	velocity.y = JUMP_VELOCITY*2
	$SoundJump.play()
	coyouteTime = 0

func appent_to_conn_vector(vec):
	print(vec)
	conn_x += vec.x if abs(conn_x) < SPEED*0.8 else 0
	conn_y += vec.y if abs(conn_y) < abs(JUMP_VELOCITY)*0.06 else 0

func update_animation_parameters():
	if is_death:
		set_anim_tree(false, false, false, true,false)
	elif is_on_floor():
		if velocity == Vector2.ZERO:
			set_anim_tree(true, false, false, false, false)
		else:
			set_anim_tree(false, true, false, false, false)
	else:
		set_anim_tree(false, false, true, false, false)
	
	if !is_death:
		if Input.is_action_just_pressed("m_right"):
			flip_anim(false)
		elif Input.is_action_just_pressed("m_left"):
			flip_anim(true)

#Установка анимаций: idle, move и jump
func set_anim_tree(is_idle : bool, is_moving : bool, is_jumping : bool, is_dying: bool, is_action : bool):
	animation_tree["parameters/conditions/idle"] = is_idle
	animation_tree["parameters/conditions/is_moving"] = is_moving
	animation_tree["parameters/conditions/is_jumping"] = is_jumping
	animation_tree["parameters/conditions/is_death"] = is_dying
	animation_tree["parameters/conditions/is_action"] = is_action
	if is_death and !anim_off:
		anim_off = true
		get_tree().create_timer(1).timeout.connect(set_anim_off)
	elif !is_death:
		anim_off = false
		animation_tree.active = true
	
	idle_sprite.visible = is_idle 
	walk_sprite.visible = is_moving 
	jump_sprite.visible = is_jumping
	death_sprite.visible = is_dying
	action_sprite.visible = is_action 

func set_anim_off():
	animation_tree.active = false

func flip_anim(is_left):
	idle_sprite.flip_h = is_left
	walk_sprite.flip_h = is_left
	jump_sprite.flip_h = is_left
	death_sprite.flip_h = is_left
	action_sprite.flip_h = is_left
	walk_sprite.offset.x = -10 if is_left else 10


func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		onRope = true


func _on_area_2d_body_exited(body):
	if body.get_name() == "Player":
		onRope = false


func _to_die(status = true):
	if status:
		$SoundDeath.play()
	is_death = status
	Global.ser_visible_dead_text(status)
