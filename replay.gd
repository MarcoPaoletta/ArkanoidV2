extends Node2D





func but_replay_pressed():
	get_tree().paused = false
	TRANSITION.change_scene("res://world.tscn")

func but_quit_pressed():
	get_tree().quit()

 
