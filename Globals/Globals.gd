extends Node

const DICE = 4

func _ready():
	pass 

func loadJSON(file_path):
	var data_file = File.new()
	if data_file.open(file_path, File.READ) != OK:
		print("data read error")
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		print("data parse error")
	var data = data_parse.result
	return data
