extends StaticBody2D

func _physics_process(delta):
	if self.visible == true:
		pass

func _on_button_pressed():
	if Global.coins >= 50:
		Global.playerhealth += 25
		Global.coins -= 50
		print("buy")

