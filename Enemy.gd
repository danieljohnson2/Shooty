extends RigidBody2D

# Where the Enemy moves and how it shoots
export var left = 100
export var right = 900

var speed = 300
var direction = -1

onready var bulletTemplate = preload("res://Bullet.tscn")

func _process(delta):
	# Move back and forth
	self.position.x += direction * speed * delta
	if self.position.x > right: direction = -1
	if self.position.x < left: direction = 1

	

func _on_Enemy_body_entered(body):
	pass
