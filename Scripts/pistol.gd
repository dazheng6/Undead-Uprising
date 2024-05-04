extends Sprite2D

@onready var pistol = $"."
@onready var muzzleFlash = $"MuzzelFlash-removebg-preview"
@onready var ammo = Global.ammo_count
@onready var ammo_is_zero = false

func _process(delta):
	if Input.is_action_pressed("shoot"):
		ammo = 30
		
	if ammo <= 0:
		print(ammo)
		ammo_is_zero = true
		
	if Input.is_action_just_pressed("shoot") and ammo > 0 and !ammo_is_zero:
		ammo -= 1
		muzzleFlash.show()
		$Timer.start()
		
func _on_timer_timeout():
	muzzleFlash.hide()
