extends Area2D

var Body
var rota

func _ready() -> void:
	$Sprite2D.flip_v = Body.PlayerMovements.dir.x < 0
	rota = Body.PlayerMovements.dir
	rotation = rota.angle()
	$AnimationPlayer.play("hit")

func hit() -> void:
	print(get_overlapping_bodies())
	for b in get_overlapping_bodies():
		b.get_hit(12, rota.normalized())
