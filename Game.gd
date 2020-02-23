extends Node2D

var spawn_delay = 0
export var spawn_time = 150

onready var matrixDotTemplate = preload("res://MatrixDot.tscn")

func _process(delta):
	if spawn_delay <= 0:
		var dot = matrixDotTemplate.instance()
		dot.position.x = rand_range(0, 1000)
		self.add_child(dot)
		spawn_delay = spawn_time
	spawn_delay -= delta
	
	# Needs to work after the player dies, so can't be in Player.gd
	if Input.is_action_pressed("ui_quit"):
		get_tree().quit()
