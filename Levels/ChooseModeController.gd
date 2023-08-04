extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("tab_mode") and has_node("ChooseMode"):
		$ChooseMode.visible = !$ChooseMode.visible
		$TabMode.visible = !$TabMode.visible
	if Input.is_action_just_pressed("btn_back") and has_node("ChooseMode"):
		$ChooseMode.visible = false
		$TabMode.visible = true
