extends CharacterBody2D

@onready var PlayerMovements = get_node("Player Movements")
@onready var PlayerLogic = get_node("Player Logic")
@onready var PlayerInventory = get_node("Player Inventory")
@onready var Weapon = get_node("Weapon")

func _physics_process(delta: float):
	PlayerMovements.movement_process(delta)
	PlayerLogic.logic_process(delta)

func _ready() -> void:
	PlayerLogic.init_inventory()
