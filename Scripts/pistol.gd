extends Sprite2D

@onready var pistol = $"."
@onready var muzzleFlash = $"MuzzelFlash-removebg-preview"

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		muzzleFlash.show()
		$Timer.start()
		
func _on_timer_timeout():
	muzzleFlash.hide()
