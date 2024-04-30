extends Area2D

var velocity = Vector2.ZERO
var speed = 2000
@onready var bulletQueueFree = $Timer
@onready var bulletDestroyParticle = preload("res://Scenes/bullet_destroy_particle.tscn")
@onready var bullet = $"."

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


func _on_body_entered(body):
	if body.is_in_group("wall"):
		var destroyParticle = bulletDestroyParticle.instantiate()
		get_parent().add_child(destroyParticle)
		destroyParticle.position = bullet.global_position + Vector2(-18, -13)
		print(bullet.global_position)
		queue_free()
		
