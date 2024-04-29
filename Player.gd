extends CharacterBody2D

@export var Bullet: PackedScene
var speed = 100
var accel = 1500
var friction = 600

var input = Vector2.ZERO

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(speed*3)
	move_and_slide()

func shoot():
	#owner.add_child(Bullet)
	#Bullet.transform = $Gun.global_transform
	pass

func _physics_process(delta):
	player_movement(delta)
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
