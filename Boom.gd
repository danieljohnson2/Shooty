extends Node2D

var movement = Vector2(0, 0)
var explodyness = .25
const max_explodyness = 1.5

func _process(delta):
	self.position += movement * delta
	
	# Handle exposion animation
	if explodyness > max_explodyness:
		self.queue_free()
	else:
		var fraction = (max_explodyness - explodyness) / max_explodyness
		self.scale = Vector2(explodyness, explodyness)
		self.modulate = Color(1, fraction, fraction, fraction) 
		explodyness *= 1.1