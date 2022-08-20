extends Area2D

func _ready():
	pass

func _on_Star_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_method("collect_star"):
			body.collect_star()
		queue_free()
