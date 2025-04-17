extends Node

@onready var Body: CharacterBody2D = get_node("..")
@onready var PlatformDetectionArea: Area2D = get_node("../Platform Detection Area")

var velocity: Vector2 = Vector2()
var speed: float = 512
var crouch_modifier: float = 0.6
var is_crouched: bool = false
var jump: float = 512+128
var wall_jump: float = (512+128)*1.3
var gravity: float = 2048
var floor_accel: float = 30 # 33ms
var air_accel: float = 3 # 167ms
var looking_dir: int = 1
var sticked_to_wall: bool = false
var walk_dir: float = 0
var dir: Vector2 = Vector2()


## Executed from player_body.gd
func movement_process(delta: float):
	
	velocity = Body.velocity
	horizontal_movement(delta)
	vertival_movement(delta)
	wall_movement()
	a()
	
	dir = Body.get_local_mouse_position()
	if Input.is_action_pressed("down"):
		is_crouched = true
		$"../Sprite".texture = load("res://assets/visual/sprites/player/crouched.png")
	else:
		is_crouched = false
		$"../Sprite".texture = load("res://assets/visual/sprites/player/tempPlayer.png")
	Body.velocity = velocity
	Body.move_and_slide()


func vertival_movement(delta: float):
	if Body.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump
	else:
		if sticked_to_wall:
			if Input.is_action_just_pressed("jump"):
				velocity.y = -jump/1.33
				velocity.x = speed*looking_dir
				sticked_to_wall = false
			velocity.y += gravity * delta
			velocity.y = min(256, velocity.y)
		else:
			velocity.y += gravity * delta
	Body.set_collision_mask_value(2, velocity.y >= 0 and PlatformDetectionArea.has_overlapping_bodies())


func horizontal_movement(delta: float):
	var accel = get_accel()
	walk_dir = Input.get_axis("left", "right")
	velocity.x -= velocity.x * delta * accel
	velocity.x += walk_dir * delta * accel * speed * (crouch_modifier if is_crouched else 1.)

func wall_movement():
	check_stick_to_wall()
	check_unstick_to_wall()


func check_stick_to_wall():
	if Body.is_on_floor():
		return
	var wall_check_rays: Array = [$"../Wall2/wall left ckeck", $"../Wall2/wall right ckeck"]
	for i in range(len(wall_check_rays)):
		var wall_check_ray = wall_check_rays[i]
		var check_ray_direction: int = (i * 2 - 1)
		if wall_check_ray.is_colliding() and Body.velocity.x * check_ray_direction >= 0:
			looking_dir = -check_ray_direction
			Body.get_node("Sprite").flip_h = i
			sticked_to_wall = true
			return


func check_unstick_to_wall():
	if !sticked_to_wall:
		return
	
	var wall_check_ray: RayCast2D
	if sign(looking_dir) == 1:
		wall_check_ray = $"../Wall2/wall left ckeck"
	else:
		wall_check_ray = $"../Wall2/wall right ckeck"
	
	if Body.is_on_floor() or !wall_check_ray.is_colliding():
		sticked_to_wall = false


## Ternary Operator wich generates accel 
## 1/accel = Time needed to go from 0% speed to 50% speed (1/x speed progression)
func get_accel():
	return floor_accel if Body.is_on_floor() else air_accel # Ternary operator


## A RENAME ! J'AI JUSTE PAS DE NOM
## Oriente le joueur et ptet des anims de walk et tt la dedans aussi
func a():
	if !Body.is_on_floor():
		return
	var input_dir: int = sign(walk_dir)
	if input_dir and looking_dir != input_dir:
		looking_dir = input_dir
		Body.get_node("Sprite").flip_h = looking_dir == -1
