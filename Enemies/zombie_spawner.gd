extends Node2D

@onready var zombie = preload("res://Enemies/zombie.tscn")
@onready var level_completed = Global.level_completed
@onready var zombieTimer = $ZombieSpawnTimer
@onready var spawnPosition = $Marker2D.global_position

func _process(delta):
	return

func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and !level_completed:
		zombieTimer.start()
		print("zombie spawner")


func _on_zombie_spawn_timer_timeout():
	var zombiePath = zombie.instantiate()
	get_parent().add_child(zombiePath)
	zombiePath.global_position = spawnPosition
	zombieTimer.stop()
	
