extends Sprite2D

@onready var pistol = $"."

func _process(delta):
	if Input.is_action_pressed("move_left"):
		pistol.scale.x = -.2
		pistol.position.x = -5
		
	if Input.is_action_pressed("move_right"):
		pistol.scale.x = .2
		pistol.position.x = 5
