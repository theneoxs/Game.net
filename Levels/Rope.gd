extends Line2D

@onready var l:Line2D
@onready var col:CollisionShape2D
var toclick = false
var spawnpoint

# Called when the node enters the scene tree for the first time.
func _ready():
	#setRope(Vector2(0, 0), Vector2(500,500))
	pass


func setRope(currentpos, desiredPos):
	col = get_parent()
	col.shape.a = currentpos
	col.shape.b = desiredPos
	add_point(col.shape.a)
	add_point(col.shape.b)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click_l") and toclick:
		setRope(Vector2(spawnpoint.global_position.x, spawnpoint.global_position.y), get_global_mouse_position())
		toclick = false
		if get_parent().get_parent().get_parent().has_node("Player/Dot"):
			get_parent().get_parent().get_parent().get_node("Player/Dot").queue_free()
