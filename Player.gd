extends Area2D

var right_angle = PI/2
var deadzone_angle = PI/20

onready var bulletTemplate = preload("res://Bullet.tscn")
	
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
		var bullet = bulletTemplate.instance()
		bullet.global_position = self.global_position
		var target_position = get_global_mouse_position()
		bullet.shoot_at(target_position, self, 20, 200)

func _on_Player_body_entered(body):
	if body.is_in_group("Enemy"):
		self.queue_free()