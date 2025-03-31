extends CharacterBody2D

func _process(delta: float) -> void:
	move_and_slide()
	if get_last_slide_collision():
		queue_free()
		
	var enemies = $Area2D.get_overlapping_bodies()
	for body in enemies:
		body.get_hit(12, position.direction_to(body.position))
		queue_free()
