extends RigidBody2D

export var speed = 300
export var duration = 1.5

var explodyness = 0
const max_explodyness = 1.5

func _process(delta):
	self.position.y -= delta * speed
	
	if explodyness > max_explodyness:
		self.queue_free()
	if explodyness > 0:
		var boom = $"Boom"
		var fraction = (max_explodyness - explodyness) / max_explodyness
		boom.scale = Vector2(explodyness, explodyness)
		boom.modulate = Color(1, fraction, fraction, fraction) 
		explodyness *= 1.1
	else:
		duration -= delta
		if duration <= 0:
			self.queue_free()

func _on_Bullet_body_entered(body):
	body.queue_free()
	explodyness = .25
	$"Boom".visible = true