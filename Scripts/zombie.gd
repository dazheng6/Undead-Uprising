extends Area2D

var bulletPath = preload("res://Scenes/bullet.tscn")
@onready var zombieHitTime = $Timer

func _ready():
	zombieHitTime.start()

func shoot():
	var bullet_instance = bulletPath.instantiate()
	add_child(bullet_instance)
	rotation_degrees = $Marker2D.rotation_degrees
	var direction = Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees))
	bullet_instance.set_velocity(-direction)

func _on_timer_timeout():
	shoot()
	print("ZombieHitTime Start")
