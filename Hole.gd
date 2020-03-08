extends Area2D

export var growth_speed = 0.25

var falling_in = []

func top_position(): return global_position.y

func _ready():
	scale = Vector2(0.125, 0.125)
	
func _process(delta):
	var expansion = scale.x
	expansion = min(1, expansion + growth_speed * delta)	
	#scale = Vector2(expansion, expansion)
	
	for n in falling_in:
		if is_instance_valid(n): fall_in(n, delta)

func _on_Hole_body_entered(body):
	if body.is_in_group("Enemy") and not body in falling_in:
		falling_in.append(body)
		$"../Background".speed += 1

func _on_Hole_area_entered(area):
	if area.is_in_group("Player") and not area in falling_in:
		falling_in.append(area)

func fall_in(victim, delta):
	# Shrinks the victim and moves it towards the hole;
	# removes it when small enough.
	var sprite = victim.get_node("Sprite")
	
	if sprite == null:
		# No spite? No animation- just kill it!
		falling_in.erase(victim)
		victim.queue_free()
	else:		
		sprite.scale.x = max(0, sprite.scale.x - delta)
		sprite.scale.y = max(0, sprite.scale.y - delta)
	
		if sprite.scale.x < 0.01:
			falling_in.erase(victim)
			victim.queue_free()
		elif self.position != victim.position:
			var x = (self.position - victim.position).normalized()
			victim.position += x * 100 * delta
