extends RigidBody2D

export var speed = 300
export var duration = 1.5


func _process(delta):
	self.position.y -= delta * speed
	duration -= delta
	if duration <= 0:
		self.queue_free()