extends RigidBody2D

var speed = 100
var direction = -1
var left = 100
var right = 900

func _process(delta):
	self.position.x += direction * speed * delta
	if self.position.x > right: direction = -1
	if self.position.x < left: direction = 1
	
func _on_Enemy_body_entered(body):
	if body.is_in_group("Bullet"):
		body.queue_free()
		self.queue_free()