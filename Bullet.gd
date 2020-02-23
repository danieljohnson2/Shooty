extends RigidBody2D

var movement = Vector2(0, 0)
var holeTemplate = preload("res://Hole.tscn")
export var start_position = Vector2(0, 0)
var already_intersected = []

func shoot_at(global_target, shooter, offset, speed):
	# Adds this bullet to the scene with rotation, position and speed
	# to shoot at 'global target', startin at 'shooter' but offset
	# by 'offset' so we don't hit the shooter
	
	var angle = shooter.rotation + shooter.get_angle_to(global_target) - PI/2
	shooter.get_parent().add_child(self)
	self.rotation = angle
	self.position = shooter.position + Vector2(0, offset).rotated(angle)
	self.movement = Vector2(0, speed).rotated(angle)
	start_position = self.global_position

func _draw():
	draw_line(to_local(start_position), Vector2(0, 0), Color(0, 0, 0), 1)
	
func _process(delta):
	self.position += movement * delta
	start_position.y += $"../Background".speed * delta
	update()
	
	for n in self.get_tree().get_nodes_in_group("Bullet"):
		if n != self and n.global_position.y < self.global_position.y and not n in already_intersected:
			var inter = Geometry.segment_intersects_segment_2d(
			    start_position, self.global_position,
				n.start_position, n.global_position)
			if inter != null:
				var arm1 = inter - start_position
				var arm2 = inter - n.start_position
				var angle1 = arm1.angle() - PI/2
				var angle2 = arm2.angle() - PI/2
				var angleResult = abs(angle1 - angle2)/2
				if (angleResult > 0.2):
					already_intersected.append(n)
					var hole = holeTemplate.instance()
					hole.global_position = inter
					self.get_parent().add_child(hole)
					hole.rotation = (angle1 + angle2) / 2
					hole.scale = Vector2(angleResult, 1)

func _on_Bullet_body_entered(body):
	# Destroy what the bullet hits and the bullet
	body.queue_free()
	
	# but show an explosion
	var hole = holeTemplate.instance()
	hole.position = self.position
	self.get_parent().add_child(hole)
