extends PathFollow2D

@export var slither_speed = 200
@onready var path:Path2D = get_parent()
@onready var l:Line2D


# Called when the node enters the scene tree for the first time.
func _ready():   
	l = path.get_child(1)
	for point in path.curve.get_baked_points():  
		l.add_point(point) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_progress(get_progress() + slither_speed * delta)
	$SawSprite.rotation += delta*5
