extends Node2D

signal spawn_point_reached

var is_playing = false

func _physics_process(delta):
	if not is_playing:
		return

	if position.x <= -1616:
		print("Removing ground...")
		queue_free()
	else:
		position += Vector2(-100 * delta, 0)

func _on_SpawnPoint_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("spawn_point_reached")

func stop():
	is_playing = false

func resume():
	is_playing = true
