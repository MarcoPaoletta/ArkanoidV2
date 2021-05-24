extends RigidBody2D

func _ready():
	randomize()
	var random0 = randi() % 6 
	$spr_gift.frame = random0

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_gift_body_entered(body):
	if body is Player:
		GLOBALS.emit_signal("gift_picked")
		queue_free()

