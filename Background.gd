extends Sprite

export var speed = 40

func _process(delta):
	for idx in range(0, self.get_parent().get_child_count()):
		var n = self.get_parent().get_child(idx)
		n.position.y += speed * delta
	
		if n == self:
			while self.position.y >= 0:
				self.position.y -= self.texture.get_height() * self.scale.y
		elif n.position.y > 620:
			n.queue_free()
	pass
