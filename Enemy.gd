extends RigidBody2D

onready var sprite = $"Sprite"

func _ready():
	self.linear_velocity = Vector2(rand_range(-100, 100),rand_range(-100, 100))
