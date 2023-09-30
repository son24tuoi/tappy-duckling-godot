extends Control


@onready var high_score_label = $MC/HB/HighScoreLabel


func _ready():
	high_score_label.text = str(GameManager.get_high_score())


func _process(_delta):
	if Input.is_action_just_pressed("fly"):
		GameManager.load_game_scene()
