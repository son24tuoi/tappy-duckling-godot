extends CharacterBody2D


@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D


const GRAVITY : float = 1900.0
const POWER : float = -400


var _dead: bool = false


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	velocity.y += GRAVITY * delta
	
	fly()
	
	move_and_slide()
	
	if is_on_floor():
		die()


func fly() -> void:
	
	if Input.is_action_just_pressed("fly"):
		velocity.y = POWER
		animation_player.play(("fly"))


func die() -> void:
	if _dead:
		return
	
	_dead = true
	animated_sprite_2d.stop()
	GameManager.on_game_over.emit()
	set_physics_process(false)
