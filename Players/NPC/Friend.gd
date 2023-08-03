extends Area2D
@onready var animation_tree: AnimationTree = $AnimationTree


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.get_name() == "Player":
		Global.play_rescue_sound()
		Global.count_rescued_friends += 1
		queue_free()
