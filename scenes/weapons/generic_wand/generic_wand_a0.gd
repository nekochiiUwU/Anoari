extends Area2D

var Body
var rota

func _ready() -> void:
	$Sprite2D.flip_v = Body.PlayerMovements.dir.x < 0
	rota = Body.PlayerMovements.dir
	rotation = rota.angle()
	$AnimationPlayer.play("hit")

func hit() -> void:
	var proj = load("res://scenes/weapons/generic_wand/projectiles/generic_wand_proj_a0.tscn").instantiate()
	proj.rotation = rotation
	proj.velocity = proj.transform.x*600
	proj.global_position = global_position
	Body.get_parent().add_child(proj)
	
