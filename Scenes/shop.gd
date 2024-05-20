extends StaticBody2D

func _ready():
	$shopmenu.visible = false
	
func _on_area_2d_body_entered(body):
	if body.has_method("player_shop_method"):
		$shopmenu.visible = true
		print("openshop")


func _on_area_2d_body_exited(body):
	$shopmenu.visible = false
