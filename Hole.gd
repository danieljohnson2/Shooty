extends Area2D

export var growth_speed = 0.25

var falling_in = []

func _ready():
	scale = Vector2(0.125, 0.125)
	
func _process(delta):
	var expansion = scale.x
	expansion = min(1, expansion + growth_speed * delta)	
	scale = Vector2(expansion, expansion)
	rotation = (1 - expansion) * PI/2
	
	for n in falling_in:
		var new_scale = n.shrink(-1 * delta)
		if new_scale < 0.01:
			n.queue_free()
			falling_in.erase(n)
		elif self.position != n.position:
			var x = (self.position - n.position).normalized()
			n.position += x * 100 * delta
	
func _on_Hole_body_entered(body):
	if body.is_in_group("Enemy") and not body in falling_in:
	#	body.mode = RigidBody2D.MODE_KINEMATIC
		falling_in.append(body)
		$"../Background".speed += 1

func _on_Hole_area_entered(area):
	if area.is_in_group("Player") and not area in falling_in:
		falling_in.append(area)
