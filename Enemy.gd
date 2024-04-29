extends Node2D

@export var Bullet1: PackedScene
@export var Bullet2: PackedScene
@export var Bullet3: PackedScene
@export var Bullet4: PackedScene
@export var Bullet5: PackedScene
@export var Bullet6: PackedScene

@onready var shoot_timer = $ShootTimer
@onready var rotator = $Rotator
@onready var 

@export var RotationSpd = 100
@export var TimerWaitTime = 0.5
@export var SpawnCount = 4
@export var Radius = 100

var bullets = [Bullet2, Bullet3, Bullet4, Bullet5, Bullet6]

func _ready():
	var step = 2 * PI / SpawnCount
	
	for i in range(SpawnCount):
		var spawn_point = Node2D.new()
		var pos = Vector2(Radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)
	
	shoot_timer.wait_time = TimerWaitTime
	shoot_timer.start()

func _process(delta):
	var new_rotation = rotator.rotation_degrees + RotationSpd * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)

func _on_shoot_timer_timeout():
	RotationSpd += 2
	for s in rotator.get_children():
		var bullet1 = Bullet1.instantiate()
		get_tree().root.add_child(bullet1)
		bullet1.position = s.global_position
		bullet1.rotation = s.global_rotation
		#print(s.global_position)

func _on_count_change_timer_timeout():
	SpawnCount = randi_range(1, 5)
	print(SpawnCount)

func _on_bullet_timer_timeout():
	
	if Bullet2.can_instantiate():
		for s in rotator.get_children():
			var bullet2 = Bullet2.instantiate()
			get_tree().root.add_child(bullet2)
			bullet2.position = s.global_position
			bullet2.rotation = s.global_rotation
