extends Camera2D

var accel: float = 6

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= position * delta * accel
	position += $"../Player Body".position * delta * accel
	position.y -= position.y*delta*15
