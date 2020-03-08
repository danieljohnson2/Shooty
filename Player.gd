extends Area2D

var right_angle = PI/2
var deadzone_angle = PI/20

export var speed = 200
var directions = {
	"ui_right": Vector2(1, 0),
	"ui_left": Vector2(-1, 0),
	"ui_up": Vector2(0, -1),
	"ui_down": Vector2(0, 1) }
	
onready var bulletTemplate = preload("res://Bullet.tscn")

func top_position(): return global_position.y

func _process(delta):
	var movement = Vector2(0,0)
	for action in directions.keys():
		if Input.is_action_pressed(action):
			movement += directions[action]
	self.position += movement * delta * speed
	
	var rot = get_global_mouse_position().angle_to_point(self.global_position) + PI/2
	
	if rot < PI-deadzone_angle or rot > PI+deadzone_angle:
		# Don't allow player to face downwards. We get angles from
		# -PI/2 to 3/2*PI for some reason.
		if rot > PI: rot = -right_angle
		elif rot > PI/2: rot = right_angle
		elif rot < -PI/2: rot = right_angle
		
		self.rotation = rot
		
	if Input.is_action_just_pressed("ui_shoot"):
		var bullet = bulletTemplate.instance()
		bullet.global_position = self.global_position
		var target_position = get_global_mouse_position()
		bullet.shoot_at(target_position, self, 20, 200)

func _on_Player_body_entered(body):
	if body.is_in_group("Enemy"):
		self.queue_free()