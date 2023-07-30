extends RigidBody2D

func _ready():
	pass


func _process(delta):
	pass

var count_collision = 0

func _on_body_entered(body):
	if body.get_name() == "Player":
		count_collision += 1
		if count_collision >= 6:
			queue_free()


