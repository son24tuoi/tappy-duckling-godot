extends Node


signal on_game_over
signal on_score_updated


const GROUP_PLANE: String = "plane"
const SAVE_PATH: String = "user://savegame.json"


var game_scene: PackedScene = preload("res://game/game.tscn")
var main_scene: PackedScene = preload("res://main/main.tscn")


var _score: int = 0

var player_data = PlayerData.new()


func get_score() -> int:
	return _score


func get_high_score() -> int:
	return player_data.high_score


func set_score(v: int) -> void:
	_score = v
	if _score > player_data.high_score:
		save_data()
	on_score_updated.emit()


func increment_score() -> void:
	set_score(_score + 1)


func load_game_scene() -> void:
	get_tree().change_scene_to_packed(game_scene)


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)


func save_data() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		print(FileAccess.get_open_error())
		return
	
	var data = {
		"player_data": {
			"high_score": _score
		}
	}
	
	var json_string = JSON.stringify(data, "\t")
	file.store_string(json_string)
	file.close()


func load_data() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file == null:
			print(FileAccess.get_open_error())
			return
		
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data == null:
			print("data is null...")
			return
		
		player_data = PlayerData.new()
		player_data.high_score = data.player_data.high_score
	else:
		print("no data saved...")



















