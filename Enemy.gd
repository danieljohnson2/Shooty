extends RigidBody2D

func _ready():
	self.linear_velocity = Vector2(rand_range(-100, 100),rand_range(-100, 100))

func _process(delta):
	pass	

func _on_Enemy_body_entered(body):
	pass
