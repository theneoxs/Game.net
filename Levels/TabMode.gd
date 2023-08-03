extends ColorRect

func _ready():
	visible = false

func _process(delta):
	if !get_parent().has_node("ChooseMode"):
		queue_free()
