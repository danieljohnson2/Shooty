extends RigidBody2D

var flocker = null

func top_position(): return global_position.y

func _ready():
	self.linear_velocity = Vector2(rand_range(-100, 100),rand_range(-100, 100))
	
func _process(delta):
	if flocker != null and is_instance_valid(flocker):
		self.linear_velocity = flocker.linear_velocity

func _on_Enemy_body_entered(body):
	if body.is_in_group("Enemy"):
		flocker = body