extends Control

@onready var httpRequest = $HTTPRequest
@onready var table = $ScrollContainer/VBoxContainer
@onready var loading = $Loading
@onready var no_data = $NoData

var res_mas = []

var line_table = load("res://GUI/line.tscn")

var type_sort = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)
	no_data.visible = true
	loading.visible = true
	httpRequest.request(Global.url_server + "/ldbrd")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_mouse_entered():
	Global.play_btn_in()

func _on_btn_click():
	Global.play_btn_click()

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)

func _on_next_pressed():
	_on_btn_click()
	no_data.visible = false
	loading.visible = true
	httpRequest.request(Global.url_server + "/ldbrd")
	$HBoxContainer/CheckLvlTotal.button_pressed = true


func _on_back_pressed():
	_on_btn_click()
	Global.set_next_scr("res://GUI/main_menu.tscn")

func send_HTTPRequest(url, data, use_ssl = false):
	var query = JSON.stringify(data)
	var headers = ["Content-Type: application/json"]
	httpRequest.request(url, headers, HTTPClient.METHOD_POST, query)

func _on_http_request_request_completed(result, response_code, headers, body):
	loading.visible = false
	no_data.visible = false
	var res = JSON.parse_string(body.get_string_from_utf8())
	var a = {}
	if res != null:
		if !("data" in res.keys()):
			no_data.visible = true
		elif res["data"] == []:
			no_data.visible = true
		else:
			res_mas = res["data"]
			sort_table("total")
	else:
		no_data.visible = true

func clear_table():
	for i in table.get_children():
		i.queue_free()

func sort_table(sort_type):
	type_sort = sort_type
	if sort_type in ["x", "y", "z", "a", "b"]:
		res_mas.sort_custom(func(a, b): return float(a[type_sort]) < float(b[type_sort]))
	elif sort_type == "total":
		res_mas.sort_custom(sort_by_total)
	elif sort_type == "name":
		res_mas.sort_custom(func(a, b): return str(a[type_sort]) < str(b[type_sort]))
	draw_table()

func sort_by_total(a, b):
	var total1 = float(a["x"]) + float(a["y"]) + float(a["z"]) + float(a["a"]) + float(a["b"])
	var total2 = float(b["x"]) + float(b["y"]) + float(b["z"]) + float(b["a"]) + float(b["b"])
	if total1 < total2:
		return true
	return false

func draw_table():
	clear_table()
	var num = 1
	table.add_child(line_table.instantiate())
	for i in res_mas:
		var row_table = line_table.instantiate()
		table.add_child(row_table)
		row_table.get_data(num, i)
		num += 1

func _on_name_check_pressed():
	sort_table("name")

func _on_check_lvl_1_pressed():
	sort_table("x")

func _on_check_lvl_2_pressed():
	sort_table("y")

func _on_check_lvl_3_pressed():
	sort_table("z")

func _on_check_lvl_4_pressed():
	sort_table("a")

func _on_check_lvl_5_pressed():
	sort_table("b")

func _on_check_lvl_total_pressed():
	sort_table("total")
