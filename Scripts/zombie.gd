extends Area2D

var bulletPath = preload("res://Scenes/bullet.tscn")
@onready var zombieHitTime = $Timer
@onready var zombieHealth = 100.0

func _process(delta):
	if zombieHealth == 0:
		queue_free()
		print("Zombie Died")

func shoot():
	var bullet_instance = bulletPath.instantiate()
	add_child(bullet_instance)
	rotation_degrees = $Marker2D.rotation_degrees
	var direction = Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees))
	bullet_instance.set_velocity(-direction)

func _on_hazard_detector_area_entered(area):
	print("Zombie Shoot")
	shoot()

func _on_area_entered(area):
	print("Zombie -25 HP")
	zombieHealth -= 25
	var zombie = get_tree().get_nodes_in_group("Zombie")
	if zombie.size() == 0:
		print("All Zombies Dead")
		Events.level_completed.emit()
