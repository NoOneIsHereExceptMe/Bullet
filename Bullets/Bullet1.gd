extends Node2D

@export var Speed = 100

func _process(delta):
	position += transform.x * Speed #* delta

func _on_kill_timer_timeout():
	for i in range(255):
		modulate.a -= 1
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
