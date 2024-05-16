extends CenterContainer

@onready var start_game_button = %StartGameButton
@onready var audio = $HBoxContainer/SelectSound
@onready var buttonsContainer = $HBoxContainer
@onready var controlButtonPressed = false
@onready var controlsContainer = $Node2D

func _process(delta):
	if Input.is_action_pressed("Esc"):
		controlsContainer.hide()
		buttonsContainer.show()

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	start_game_button.grab_focus()

func _on_start_game_button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$HBoxContainer.hide()
	$CanvasGroup.hide()
	audio.play()
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
	LevelTransition.fade_from_black()
	
func _on_quit_button_pressed():
	audio.play()
	
	
	get_tree().quit()

func _on_button_pressed():
	controlsContainer.show()
	buttonsContainer.hide()

func _on_controls_button_pressed():
	controlsContainer.hide()
	buttonsContainer.show()
