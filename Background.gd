extends Sprite

export var speed = 40

func _process(delta):
	# These things are 'part of the paper' and move downwards with it
	var on_paper = self.get_tree().get_nodes_in_group("On Paper")
	
	for n in on_paper:
		n.position.y += speed * delta
	
	# The background gets reset so it never falls over the bottom
	while self.position.y >= 0:
		self.position.y -= self.texture.get_height() * self.scale.y

	# Everyone else is not so lucky!
	for n in on_paper:
		if n.position.y > 620:
			n.queue_free()