extends Control

@onready var time_stamp = $TimeHeader/TimeStamp
@onready var name_stamp = $NameHeader/NameStamp
@onready var friend_stamp = $FriendHeader/FriendStamp


@onready var httpRequest = $HTTPRequest

func _ready():
	Global.ready_screen()
	Global.changing_scene.connect(change_scene_to)
	time_stamp.text = Global.calc_complete_time(Global.time1 + Global.time2 +Global.time3 +Global.time4 +Global.time5 )
	var hashname = str(hash("%.2f %.2f %.2f %.2f %.2f" % [Global.time1, Global.time2, Global.time3, Global.time4, Global.time5])/10)
	name_stamp.text = hashname.sha256_text().substr(0, 10)
	friend_stamp.text = str(Global.count_rescued_friends)
	var result = {
		"token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
		"data" : {
			"name" : name_stamp.text,
			"x" : "%.2f" % Global.time1,
			"y" : "%.2f" % Global.time2,
			"z" : "%.2f" % Global.time3,
			"a" : "%.2f" % Global.time4,
			"b" : "%.2f" % Global.time5
		}
	}
	send_HTTPRequest(Global.url_server, result)
	

func _on_next_pressed():
	_on_btn_click()
	#Перемещение на уровень
	Global.set_next_scr("res://GUI/main_menu.tscn")

func change_scene_to(scene = Global.next_scr):
	get_tree().change_scene_to_file(scene)

func _on_start_mouse_entered():
	Global.play_btn_in()

func _on_btn_click():
	Global.play_btn_click()

func send_HTTPRequest(url, data, use_ssl = false):
	var query = JSON.stringify(data)
	var headers = ["Content-Type: application/json"]
	httpRequest.request(url, headers, HTTPClient.METHOD_POST, query)

func _on_http_request_request_completed(result, response_code, headers, body):
	print(result)
