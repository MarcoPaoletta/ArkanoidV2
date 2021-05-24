extends CanvasLayer

func change_scene(path):
	layer = 1
	$AnimationPlayer.play("Fade")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene(path)
	$AnimationPlayer.play_backwards("Fade")
	layer = -1
	#yield($AnimationPlayer,"animation_finished")

func _ready():
	layer = -1
