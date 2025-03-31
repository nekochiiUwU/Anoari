extends Node

@onready var Body: CharacterBody2D = get_node("..")
var equipped_weapon = 0

func logic_process(delta: float):
	check_inputs(delta)

func check_inputs(delta: float):
	if Input.is_action_just_pressed("attack"):
		#Body.Weapon.attack(Body.PlayerInventory.weapons[0], 0)
		Body.PlayerInventory.weapons[equipped_weapon].attack.call()
	if Input.is_action_just_pressed("switch_weapon"):
		equipped_weapon = (equipped_weapon + 1) % 2

func init_inventory():
	var Inventory = Body.PlayerInventory 
	Inventory.weapons = [null, null]
	Inventory.weapons[0] = {
		weapon = "sword",
		attack_scene = load("res://scenes/weapons/sword/sword_a0.tscn"),
		attack = func x():
			var a = Inventory.weapons[0].attack_scene.instantiate()
			a.Body = Body
			get_parent().add_child(a),
		special = func x():
			get_parent().add_child(load("res://scenes/weapons/sword/sword_a0.tscn").instantiate())
	}
	
	Inventory.weapons[1] = {
		weapon = "generic_wand",
		attack_scene = load("res://scenes/weapons/generic_wand/generic_wand_a0.tscn"),
		attack = func x():
			var a = Inventory.weapons[1].attack_scene.instantiate()
			a.Body = Body
			get_parent().add_child(a),
		special = func x():
			get_parent().add_child(load("res://scenes/weapons/sword/sword_slash.tscn").instantiate())
	}
