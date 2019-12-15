extends Node2D

func _process(delta):
	# Needs to work after the player dies, so can't be in Player.gd
	if Input.is_action_pressed("ui_quit"):
		get_tree().quit()