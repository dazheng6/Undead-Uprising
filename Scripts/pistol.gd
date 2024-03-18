extends Sprite2D

@onready var bullet = preload("res://Scenes/bullet.tscn")
@onready var markerPosition = $Marker2D.position

func _process(delta):
	bullet.position = Vector2(41, -1)
	
	if Input.is_action_pressed("shoot"):
		add_child(bullet)
