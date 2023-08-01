extends Area2D

signal time_to_die


func _ready():
	pass

func _process(delta):
	pass

func _on_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("time_to_die")
