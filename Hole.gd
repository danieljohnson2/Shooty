extends Area2D

func _on_Hole_body_entered(body):
	if body.is_in_group("Player"):
		body.queue_free()
		
	if body.is_in_group("Enemy"):
		body.queue_free()
		$"../Background".speed += 1