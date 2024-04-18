extends Sprite2D

@onready var shotgun = $"."

func _process(delta):
	if Input.is_action_pressed("move_left"):
		shotgun.scale.x * -1
		shotgun.position.x = -5
		
	if Input.is_action_pressed("move_right"):
		shotgun.scale.x *= 1
		shotgun.position.x = 5
		
	if Input.is_action_pressed("weapon1"):
		queue_free()
		
	if Input.is_action_pressed("weapon3"):
		queue_free()
