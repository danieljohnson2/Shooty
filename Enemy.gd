extends RigidBody2D

func _ready():
	self.linear_velocity = Vector2(rand_range(-100, 100),rand_range(-100, 100))
