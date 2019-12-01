extends RigidBody2D

var speed = 200
var directions = {
	"ui_right": Vector2(1,0),
	"ui_left": Vector2(-1,0),
	"ui_up": Vector2(0,-1),
	"ui_down": Vector2(0,1) }
	
onready var bulletTemplate = preload("res://Bullet.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Quit, Restart
	if Input.is_action_pressed("ui_quit"):
		get_tree().quit()

	var movement = Vector2(0,0)
	for action in directions.keys():
		if Input.is_action_pressed(action):
			movement += directions[action]
	self.position += movement * delta * speed
	
	if Input.is_action_just_pressed("ui_select"):
		var bullet = bulletTemplate.instance()
		bullet.position = self.position
		bullet.position.y -= 10
		get_parent().add_child(bullet)

func _on_Player_body_entered(body):
	if body.is_in_group("Bullet"):
		body.queue_free()
		self.queue_free()
