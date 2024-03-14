extends CharacterBody2D

@export var movement_data : PlayerMovementData
@export var bullet : PackedScene
var bulletPath = preload("res://Scenes/bullet.tscn")
@onready var playerHealth = 100.0
@onready var lives = 3
var air_jump = false
var just_wall_jumped = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var was_wall_normal = Vector2.ZERO
@onready var reloadTimer = $ReloadTmer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var starting_position = global_position
@onready var wall_jump_timer = $WallJumpTimer
@onready var reloadActive = false

var current_ammo = 30
var max_ammo = 30

func _ready():
	$Marker2D.position = Vector2(15,0)

func _process(delta):
	if lives == 0:
		queue_free()
		print("You Died")
	
	if playerHealth == 0:
		global_position = starting_position
		print("Player Died")
		playerHealth += 100
		lives -= 1
		
	if Input.is_action_just_pressed("move_left"):
		$Marker2D.position = Vector2(-15,0)
		$Marker2D.set_rotation(-3.14159)
		
	if Input.is_action_just_pressed("move_right"):
		$Marker2D.position = Vector2(15, 0)
		$Marker2D.set_rotation(0)
		
	if Input.is_action_just_pressed("shoot") and current_ammo > 0:
		print("Shot a bullet")
		shoot()
	if Input.is_action_just_pressed("reload") and current_ammo < max_ammo and reloadActive != true:
		reload()

func shoot():
	var bullet_instance = bulletPath.instantiate()
	current_ammo -= 1
	add_child(bullet_instance)
	bullet_instance.position = $Marker2D.position

	# Get the rotation of the marker in degrees
	var rotation_degrees = $Marker2D.rotation_degrees
	# Calculate the direction vector based on the rotation
	var direction = Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees))
	# Set the bullet's velocity
	bullet_instance.set_velocity(direction)

func reload():
	reloadTimer.start()
	print("reloading")
	reloadActive = true

func _physics_process(delta):
	apply_gravity(delta)
	handle_wall_jump()
	handle_jump()
	var input_axis = Input.get_axis("move_left", "move_right")
	handle_acceleration(input_axis, delta)
	handle_air_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	update_animations(input_axis)
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall_only()
	if was_on_wall:
		was_wall_normal = get_wall_normal()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y  >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	just_wall_jumped = false
	var just_left_wall = was_on_wall and not is_on_wall()
	if just_left_wall:
		wall_jump_timer.start()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta

func handle_wall_jump():
	if not is_on_wall_only() and wall_jump_timer.time_left >= 0.0: return
	var wall_normal = get_wall_normal()
	if wall_jump_timer.time_left > 0.0:
		wall_normal = was_wall_normal
	if Input.is_action_just_pressed("jump"):
		velocity.x = wall_normal.x * movement_data.speed * 1.5
		velocity.y = movement_data.jump_velocity * .6
		just_wall_jumped = true
		
func handle_jump():
	if is_on_floor(): air_jump = true
		
	if is_on_floor() or coyote_jump_timer.time_left < 0.0:
		if Input.is_action_just_pressed("jump"):
			velocity.y = movement_data.jump_velocity * .7
	if not is_on_floor():
		if Input.is_action_just_pressed("jump") and velocity.y < movement_data.jump_velocity / 2:
			velocity.y = movement_data.jump_velocity * .6
			
		if Input.is_action_just_pressed("jump") and air_jump and not just_wall_jumped:
			velocity.y = movement_data.jump_velocity * .7
			air_jump = false

func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration * delta)

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.air_resistnace * delta)	

func apply_air_resistance(input_axis,delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistnace * delta)

func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)
		
func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
		
	if not is_on_floor():
		animated_sprite_2d.play("jump")

func _on_hazard_detector_area_entered(area):
	print("Player Hit")
	playerHealth -= 50

func _on_reload_timer_timeout():
	current_ammo = max_ammo
	print("reloaded")
	reloadTimer.stop()
	reloadActive = false
