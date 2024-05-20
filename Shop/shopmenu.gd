extends StaticBody2D

var Player
func _physics_process(delta):
	if self.visible == true:
		pass
func _on_button_pressed():
	if Global.coins >= 50 and Global.playerHealth < 100:
		Global.playerHealth += 25
		Global.coins -= 50
		print("buy")

