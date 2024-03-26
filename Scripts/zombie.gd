extends Area2D

var bulletPath = preload("res://Scenes/bullet.tscn")
@onready var goldPath = preload("res://Scenes/gold.tscn")
@onready var zombieHitTime = $Timer
@onready var zombieHealth = 100.0
@onready var zombie = get_tree().get_nodes_in_group("Zombie")
@onready var healthbar = $ProgressBar
@onready var icon = $Icon
@onready var hazard = $HazardDetector
@onready var zombiePosition = get_node("Marker2D").global_position

func coin_spawn():
	var coin_instance = goldPath.instantiate()
	coin_instance.position = zombiePosition
	get_parent().add_child(coin_instance)
	print("Coin Spawn")

func _process(delta):
	if zombieHealth == 0:
		icon.visible = false
		coin_spawn()
		queue_free()
		print("Zombie Died")
	update_healthbar()

func update_healthbar():
	var tween = get_tree().create_tween()
	tween.tween_property(healthbar, "value", zombieHealth, 0.2)

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
	healthbar.visible = true
	update_healthbar()
	print("Zombie -25 HP")
	zombieHealth -= 25
