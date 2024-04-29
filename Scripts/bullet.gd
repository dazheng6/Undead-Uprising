extends Area2D

var velocity = Vector2.ZERO
var speed = 2000
@onready var bulletQueueFree = $Timer

func _ready():
	bulletQueueFree.start()
	
func _physics_process(delta):
	position += velocity * delta

func set_velocity(new_velocity):
	velocity = new_velocity.normalized() * speed

func _on_timer_timeout():
	queue_free()
	print("Bullet Despawn")

func _on_area_entered(area):
	if area.is_in_group("Zombie"):
		queue_free()
	
	if area.is_in_group("Wall"):
		queue_free()
