extends StaticBody2D

func _ready():
	$shopmenu.visible = false
	
func _on_area_2d_body_entered(body):
	if body.has_method("player_shop_method"):
		$shopmenu.visible = true
		print("openshop")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		

func _on_area_2d_body_exited(body):
	$shopmenu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
