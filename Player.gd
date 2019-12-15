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
	
	if Input.is_action_just_pressed("ui_shoot"):
		var bullet = bulletTemplate.instance()
		bullet.position = self.position
		# Spawn bullets off the player, as if they touch the player dies
		bullet.position.y -= 20
		get_parent().add_child(bullet)
