extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var count_collision = 0

func _on_body_entered(body):
	if body.get_name() == "Player":
		count_collision += 1
		print("connected")
		if count_collision >= 6:
			print("пора рассыпаться")
			queue_free()


