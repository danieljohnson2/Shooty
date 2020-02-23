extends RigidBody2D

var movement = Vector2(0, 0)
var holeTemplate = preload("res://Hole.tscn")
var start_position = Vector2(0, 0)

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
	draw_line(to_local(start_position), Vector2(0, 0), Color(0, 0, 0), 2)
	
func _process(delta):
	self.position += movement * delta
	start_position.y += $"../Background".speed * delta
	update()

func _on_Bullet_body_entered(body):
	# Destroy what the bullet hits and the bullet
	body.queue_free()
	self.queue_free()

	# but show an explosion
	var hole = holeTemplate.instance()
	hole.position = self.position
	self.get_parent().add_child(hole)
