extends Node

@onready var Body: CharacterBody2D = get_node("..")

func logic_process(delta: float):
	check_inputs(delta)

func check_inputs(delta: float):
	if Input.is_action_just_pressed("attack"):
		#Body.Weapon.attack(Body.PlayerInventory.weapons[0], 0)
		Body.PlayerInventory.weapons[0].attack.call()

func init_inventory():
	var Inventory = Body.PlayerInventory 
	Inventory.weapons = [null, null]
	Inventory.weapons[0] = {
		weapon = load("res://local/scenes/sword.tscn").instantiate(),
		attack = func x():
			var a = load("res://local/scenes/sword.tscn").instantiate()
			a.Body = Body
			get_parent().add_child(a), 
		special = func x():
			get_parent().add_child(load("res://local/scenes/sword.tscn").instantiate())
	}
	
