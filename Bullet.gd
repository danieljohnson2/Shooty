extends RigidBody2D

export var speed = 300
export var duration = 1.5

var explodyness = 0

func _process(delta):
	self.position.y -= delta * speed
	
	if explodyness > 1.5:
		self.queue_free()
	if explodyness > 0:
		$"Boom".scale = Vector2(explodyness, explodyness)
		explodyness *= 1.1
	else:
		duration -= delta
		if duration <= 0:
			self.queue_free()

func _on_Bullet_body_entered(body):
	body.queue_free()
	explodyness = .25
	$"Boom".visible = true