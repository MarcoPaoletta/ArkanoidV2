extends Node2D

func but_start_pressed():
	TRANSITION.change_scene("res://world.tscn")
	
func but_quit_pressed():
	get_tree().quit()

