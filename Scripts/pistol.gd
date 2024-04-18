extends Sprite2D

@onready var pistol = $"."

func _process(delta):
	if Input.is_action_pressed("move_left"):
		pistol.scale.x = -.2
		pistol.position.x = -4
		
	if Input.is_action_pressed("move_right"):
		pistol.scale.x = .2
		pistol.position.x = 4
		
	if Input.is_action_pressed("weapon2"):
		queue_free()
		
	if Input.is_action_pressed("weapon3"):
		queue_free()
