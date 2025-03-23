extends CharacterBody2D
var timer:float = 0

func _process(delta: float) -> void:
	timer += delta
	get_node("Sprite2D").frame = int(timer*6) % get_node("Sprite2D").hframes
	velocity -= velocity * delta *6
	move_and_slide()

func get_hit(dmg, direction):
	velocity += dmg*direction
