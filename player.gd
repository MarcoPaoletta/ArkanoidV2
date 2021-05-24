extends KinematicBody2D
class_name Player
export var speed = 5.5  

func _ready():
	GLOBALS.connect("gift_picked",self,"_on_gift_gift_picked")
# Movimiento
func _process(delta):
	if Input.is_action_pressed("derecha"):
		var mouvement : Vector2 = Vector2(speed,0)
		move_and_collide(mouvement)
	if Input.is_action_pressed("izquierda"):
		var mouvement : Vector2 = Vector2(-speed,0)
		move_and_collide(mouvement)
		
func enable_powerup():
	$powerup_timer.start()
	$spr_player.frame = 1
	$CollisionShape2D.shape.extents.x = 38
	$gift_sound.play()
	
func disable_powerup():
	$spr_player.frame = 0
	$CollisionShape2D.shape.extents.x = 32
	
	
func _on_gift_gift_picked():
	enable_powerup()

func _on_powerup_timer_timeout():
	disable_powerup()
	
