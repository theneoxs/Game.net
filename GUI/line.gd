extends HBoxContainer

func get_data(num, data_dict):
	$Num.text = str(num)
	$Name.text = data_dict["name"]
	$Lvl1.text = "%.2f" % (float(data_dict["x"]))
	$Lvl2.text = "%.2f" % (float(data_dict["y"]))
	$Lvl3.text = "%.2f" % (float(data_dict["z"]))
	$Lvl4.text = "%.2f" % (float(data_dict["a"]))
	$Lvl5.text = "%.2f" % (float(data_dict["b"]))
	$TotalLvl.text = "%.2f" % (float(data_dict["x"]) + float(data_dict["y"]) + float(data_dict["z"]) + float(data_dict["a"]) + float(data_dict["b"]))
