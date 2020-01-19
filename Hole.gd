extends Area2D

export var growth_speed = 0.25

func _ready():
	scale = Vector2(0.125, 0.125)
	
func _process(delta):
	var expansion = scale.x
	expansion = min(1, expansion + growth_speed * delta)	
	scale = Vector2(expansion, expansion)
	rotation = (1 - expansion) * PI/2
	
func _on_Hole_body_entered(body):
	if body.is_in_group("Player"):
		body.queue_free()
		
	if body.is_in_group("Enemy"):
		body.queue_free()
		$"../Background".speed += 1