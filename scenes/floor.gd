extends Node2D


var level:int = 0
var nb_room: int = 15
var rooms: Array = []

var max_combat = 1
var max_platform = 1


func _ready() -> void:
	pass

## 0: corridor 1: combat 2: platform
func generate_rooms(dungeon_seed):
	seed(dungeon_seed+level)
	var last_room = 0
	for i in range(nb_room):
		var next_room = randi()%3
		while (next_room == last_room):
			next_room = randi()%3
		last_room = next_room
		if (next_room == 0):
			rooms.append(load("res://scenes/maps/rooms/corridor.tscn"))
		elif (next_room == 1):
			rooms.append(load("res://scenes/maps/rooms/combat/c"+randi()%max_combat+".tscn"))
		elif (next_room == 2):
			rooms.append(load("res://scenes/maps/rooms/platform/p"+randi()%max_platform+".tscn"))
