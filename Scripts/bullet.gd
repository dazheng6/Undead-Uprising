extends Area2D

var velocity = Vector2.ZERO
var speed = 500
@onready var bulletQueueFree = $Timer

func _ready():
	bulletQueueFree.start()

func _physics_process(delta):
	position += velocity * delta

func set_velocity(new_velocity):
	velocity = new_velocity.normalized() * speed

func _on_timer_timeout():
	queue_free()

