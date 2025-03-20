extends Camera2D

var accel: float = 6

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= position * delta * accel
	position += $"../Player Body".position * Vector2(1, .25) * delta * accel
	zoom -= zoom * delta * 3
	zoom += (Vector2.ONE*1/(abs($"../Player Body".velocity.x/8192)+.9))* delta * 3
