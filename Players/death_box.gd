extends Area2D

signal time_to_die

func _ready():
	pass

func _process(delta):
	pass

func _on_body_entered(body):
	print("наступил в гавно")
	emit_signal("time_to_die")
