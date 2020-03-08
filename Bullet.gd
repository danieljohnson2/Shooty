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

func top_position():
	# Must not remove the line while either end is visible
	return min(start_position.y, global_position.y)
	
func _draw():
	draw_line(to_local(start_position), Vector2(0, 0), Color(0, 0, 0), 1)

func _process(delta):
	self.position += movement * delta
	start_position.y += $"../Background".speed * delta
	update()
	
	for n in self.get_tree().get_nodes_in_group("Bullet"):
		var inter = find_hole_intersection(n)
		if inter != null:
			var angle1 = find_angle(inter, start_position)
			var angle2 = find_angle(inter, n.start_position)
			create_hole(inter, angle1, angle2)
			
func create_hole(where, angle1, angle2):
	# Constructs a hole at 'where', for two lines
	# whose angles are given. We use the angles to place
	# the hole just so, so it appears to be part of the lines
	# If the lines are very close in agle, this creates no hole.
	
	var diff = abs(angle1 - angle2)
	if diff > 0.4:
		var hole = holeTemplate.instance()
		self.get_parent().add_child(hole)
		
		hole.global_position = where
		hole.global_rotation = (angle1 + angle2) / 2
		
		# This works if we scale up or down, but we want
		# always scale down.
		var t = tan(diff/2)
		if t > 1: hole.scale = Vector2(1, 1/tan(diff/2))
		else: hole.scale = Vector2(tan(diff/2), 1)
			
func find_hole_intersection(other_bullet):
	# Finds the place where the lines of this bullet and other_bullet intersect,
	# but only if they aren't the same and only if other_bullet is eligable ot make
	# a hole- once we find the place we will not find it again, and to avoid
	# creating holes twice, we only find it if the other bullet is below the one
	# on screen.
	
	if other_bullet == self: return null
	if other_bullet.global_position.y > self.global_position.y: return null
	if other_bullet in already_intersected: return null
	
	var inter = Geometry.segment_intersects_segment_2d(
		start_position, self.global_position,
		other_bullet.start_position, other_bullet.global_position)
	if inter != null: already_intersected.append(other_bullet)
	return inter

func find_angle(pt1, pt2):
	# Finds the angle of the line segment described,
	# so that 0 means a horizontal line.
	var diff
	if pt1.y > pt2.y:
		diff = pt1 - pt2
	else:
		diff = pt2 - pt1
	return diff.angle() - PI/2

func _on_Bullet_body_entered(body):
	# Destroy what the bullet hits and the bullet
	body.queue_free()