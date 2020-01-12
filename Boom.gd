extends RigidBody2D

func _on_Boom_body_entered(body):
	if body.is_in_group("Player"):
		body.queue_free()
		
	if body.is_in_group("Enemy"):
		body.position.y = -100
		$"../Background".speed += 1
