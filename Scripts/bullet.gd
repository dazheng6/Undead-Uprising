extends Area2D

var velocity = Vector2.ZERO
var speed = 500

func _physics_process(delta):
	position += velocity * delta

func set_velocity(new_velocity):
	velocity = new_velocity.normalized() * speed
