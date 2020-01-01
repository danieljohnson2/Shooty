extends RigidBody2D

export var speed = 200
var directions = {
	"ui_right": Vector2(1, 0),
	"ui_left": Vector2(-1, 0),
	"ui_up": Vector2(0,- 1),
	"ui_down": Vector2(0, 1) }

onready var bulletTemplate = preload("res://Bullet.tscn")

func _process(delta):
	# Who needs physics? Just move according to the keys held down
	var movement = Vector2(0,0)
	for action in directions.keys():
		if Input.is_action_pressed(action):
			movement += directions[action]
	self.position += movement * delta * speed
	self.rotation += self.get_angle_to(get_global_mouse_position()) + PI/2
		
	if Input.is_action_just_pressed("ui_shoot"):
		var bullet = bulletTemplate.instance()
		bullet.shoot_at(get_global_mouse_position(), self, 30, 400)