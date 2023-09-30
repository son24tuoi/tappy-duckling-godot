extends Control


@onready var score_label = $MC/ScoreLabel


func _ready():
	GameManager.on_score_updated.connect(on_score_updated)


func on_score_updated() -> void:
	score_label.text = str(GameManager.get_score())
