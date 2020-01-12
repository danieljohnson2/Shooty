extends RigidBody2D

export var speed = 200


onready var boomTemplate = preload("res://Boom.tscn")

func _process(delta):
	var rot = self.rotation + self.get_angle_to(get_global_mouse_position()) + PI/2
	
	self.rotation = max(-PI/2, min(rot, PI/2))
	
	self.position.x +=  (self.rotation) * delta * 200
		
	if Input.is_action_just_pressed("ui_shoot"):
		var boom = boomTemplate.instance()
		boom.global_position = get_global_mouse_position()
		self.get_parent().add_child(boom)