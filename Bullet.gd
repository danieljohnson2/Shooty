extends RigidBody2D

export var duration = 1.5

var movement = Vector2(0, 0)

var explodyness = 0
const max_explodyness = 1.5

func shoot_at(global_target, shooter, offset, speed):
	# Adds this bullet to the scene with rotation, position and speed
	# to shoot at 'global target', startin at 'shooter' but offset
	# by 'offset' so we don't hit the shooter
	
	var angle = shooter.rotation + shooter.get_angle_to(global_target) - PI/2
	shooter.get_parent().add_child(self)
	self.rotation = angle
	self.position = shooter.position + Vector2(0, offset).rotated(angle)
	self.movement = Vector2(0, speed).rotated(angle)

func _process(delta):
	self.position += movement * delta
	
	# Handle exposion
	if explodyness > max_explodyness:
		self.queue_free()
	elif explodyness > 0:
		var boom = $"Boom"
		var fraction = (max_explodyness - explodyness) / max_explodyness
		boom.scale = Vector2(explodyness, explodyness)
		boom.modulate = Color(1, fraction, fraction, fraction) 
		explodyness *= 1.1
	else:
		duration -= delta # time out the bullet with no boom
		if duration <= 0:
			self.queue_free()

func _on_Bullet_body_entered(body):
	# Destroy what the bullet hits, show explosion
	body.queue_free()
	explodyness = .25
	$"Boom".visible = true