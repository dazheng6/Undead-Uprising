extends Sprite2D

@onready var pistol = $"."

func _process(delta):
	if Input.is_action_pressed("move_left"):
		pistol.set_rotation(3.14195)
