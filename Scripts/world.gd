extends Node2D

@export var next_level: PackedScene
@onready var level_completed = $CanvasLayer/LevelCompleted

func _process(delta):
	var zombie = get_tree().get_nodes_in_group("Zombie")
	if zombie.size() == 0:
		print("All Zombies Dead")
		Events.level_completed.emit()

func _ready():
	Events.level_completed.connect(show_level_completed)
	
func show_level_completed():
	level_completed.show()
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	if not next_level is PackedScene: return
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	LevelTransition.fade_from_black()
	#get_tree().paused = true
