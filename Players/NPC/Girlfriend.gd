extends Area2D
@onready var animation_tree: AnimationTree = $AnimationTree
# Called when the node enters the scene tree for the first time.
var idle_sprite

func _ready():
	idle_sprite = $Idle
	animation_tree.active = true
	idle_sprite.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.get_name() == "Player":
		Global.play_rescue_sound()
		queue_free()
