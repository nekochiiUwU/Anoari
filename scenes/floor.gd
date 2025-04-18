extends Node2D

@onready var Bg = load("res://scenes/misc/bg.tscn")
var Player
var level:int = 0
var nb_room: int = 100
var width_tile:int = 32
var rooms: Array = []

var max_combat = 1
var max_platform = 1

var bgwidth: float
var wait = false

func _ready() -> void:
	Player = get_node("../Players/Player/Player Body")
	pass


func _process(delta: float) -> void:
	pass
	"""
	for background_instance in get_children():
		if background_instance.position.x - Player.get_node("../Camera2D").position.x < -bgwidth*1.1:
			background_instance.position.x += bgwidth*2
			background_instance.visible = false
		elif background_instance.position.x - Player.get_node("../Camera2D").position.x > bgwidth*1.1:
			background_instance.visible = false
			background_instance.position.x -= bgwidth*2
		else:
			background_instance.visible = true
			
	#print(int(Player.position.x) % int(bgwidth/2))
	#print(int(Player.position.x) % int(bgwidth))
	if not wait and int(Player.position.x) % int(bgwidth) < int(bgwidth/4):
		print("switch")
		$bg0.position.x = (Player.position.x - bgwidth)
		$bg1.position.x = (Player.position.x)
		$bg2.position.x = (Player.position.x + bgwidth)
		wait = true
	elif int(Player.position.x) % int(bgwidth) >= int(bgwidth/2):
		wait = false
	"""
		
	#$bg1.position.x = (Player.position.x + (bgwidth*1.5)) % (bgwidth*2)
	


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
			rooms.append(load("res://scenes/maps/rooms/combat/c"+str(randi()%max_combat)+".tscn"))
		elif (next_room == 2):
			rooms.append(load("res://scenes/maps/rooms/platform/p"+str(randi()%max_platform)+".tscn"))
	var pos = -16
	for r in rooms:
		var new_room = r.instantiate()
		new_room.global_position.x = pos
		add_child(new_room)
		print(new_room.get_used_rect().size.x)
		pos += new_room.get_used_rect().size.x * width_tile
	bgwidth = Bg.instantiate().texture.get_width()
	var backpos = -int(bgwidth/2)
	while backpos < pos + bgwidth:
		var new_bg = Bg.instantiate()
		new_bg.position = Vector2(backpos,0)
		add_child(new_bg)
		backpos += bgwidth
		
	
