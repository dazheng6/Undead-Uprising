extends Sprite2D

@onready var pistol = $"."
@onready var muzzleFlash = $"MuzzelFlash-removebg-preview"
@onready var ammo = Global.ammo_count
@onready var ammo_is_zero = false
@onready var gun_is_reloading = false
@onready var gun_cant_shoot = false
@onready var reloadTimer = $ReloadTimer
@onready var gunCantShootTimer = $GunBufferTime

func _process(delta):
	if Input.is_action_pressed("reload"):
		ammo = 30
		print(ammo)
		reloadTimer.start()
		gun_is_reloading = true
		
	if ammo <= 0:
		print(ammo)
		ammo_is_zero = true
		
	if Input.is_action_just_pressed("shoot") and ammo > 0 and !ammo_is_zero and !gun_is_reloading and !gun_cant_shoot:
		ammo -= 1
		$Timer.start()
		gun_cant_shoot = true
		gunCantShootTimer.start()
		muzzleFlash.show()
		
func _on_timer_timeout():
	muzzleFlash.hide()
	
func _on_reload_timer_timeout():
	gun_is_reloading = false

func _on_gun_buffer_time_timeout():
	gun_cant_shoot = false
