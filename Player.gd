extends Area2D

export var speed = 200

var right_angle = PI/2
var deadzone_angle = PI/20

onready var holeTemplate = preload("res://Hole.tscn")

func shrink(amount):
	var scale = self.scale.x
	scale += amount
	self.scale = Vector2(scale, scale)
	return scale	
	
func _process(delta):
	var rot = get_global_mouse_position().angle_to_point(self.global_position) + PI/2
	
	if rot < PI-deadzone_angle or rot > PI+deadzone_angle:
		# Don't allow player to face downwards. We get angles from
		# -PI/2 to 3/2*PI for some reason.
		if rot > PI: rot = -right_angle
		elif rot > PI/2: rot = right_angle
		elif rot < -PI/2: rot = right_angle
		
		self.rotation = rot
		self.position.x += rot * delta * 200
		
	if Input.is_action_just_pressed("ui_shoot"):
		var hole = holeTemplate.instance()
		hole.global_position = get_global_mouse_position()
		self.get_parent().add_child(hole)

func _on_Player_body_entered(body):
	if body.is_in_group("Enemy"):
		self.queue_free()