extends RigidBody2D

var speed = 100
var direction = -1
var left = 100
var right = 900
var shot_time = .5
var shot_time_remaining = 2

onready var bulletTemplate = preload("res://Bullet.tscn")

func _process(delta):
	self.position.x += direction * speed * delta
	if self.position.x > right: direction = -1
	if self.position.x < left: direction = 1
	
	shot_time_remaining -= delta
	if shot_time_remaining <= 0:
		shot_time_remaining = shot_time
		var bullet = bulletTemplate.instance()
		bullet.position = self.position + Vector2(0, 20)
		bullet.duration = 2
		bullet.speed = -200
		get_parent().add_child(bullet)
	
func _on_Enemy_body_entered(body):
	if body.is_in_group("Bullet"):
		body.queue_free()
		self.queue_free()