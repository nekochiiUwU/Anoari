extends CharacterBody2D

@onready var PlayerMovements = get_node("Player Movements")


func _physics_process(delta: float):
	PlayerMovements.movement_process(delta)
