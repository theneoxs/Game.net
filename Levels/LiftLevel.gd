extends PathFollow2D

@export var slither_speed:int 
@onready var path:Path2D = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_progress(get_progress() + slither_speed * delta)
