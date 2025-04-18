extends CharacterBody2D

var Target = null

var max_hp:float = 60
var hp:float = max_hp
var timer:float = 0
var is_dead: bool = false
var death_timer = 0
var gravity: float = 2048
var death_duration = 0.5

var max_action_cd = 1.5
var action_cd = max_action_cd
var is_moving = false

func _process(delta: float) -> void:
	timer += delta
	
	velocity -= velocity * delta * 6
	
	if is_dead:
		velocity.y += gravity * delta
		scale -= Vector2(1,1)*delta*0.75*(1/death_duration)
		rotation_degrees += velocity.x * delta
		modulate.a -= delta * 1/death_duration
		if timer - death_timer > death_duration:
			queue_free()
	else:
		get_node("Sprite2D").frame = int(timer*6) % get_node("Sprite2D").hframes
		if Target:
			action_cd -= delta
			var goal = get_nearest_goal()
			if is_moving:
				velocity += (goal - global_position) * delta * 8
				if goal.distance_to(global_position) < 50:
					#velocity = Vector2()
					is_moving = false
					action_cd = max_action_cd
			elif action_cd <= 0:
				print(goal ,global_position)
				if goal.distance_to(global_position) < 50:
					attack()
				else:
					is_moving = true
				action_cd = max_action_cd
		else:
			var best_dist = 1500 
			var best_p = null
			for p in get_node("../Players").get_children():
				if p.get_node("Player Body").global_position.distance_to(global_position) < best_dist:
					best_dist = p.get_node("Player Body").global_position.distance_to(global_position) 
					best_p = p.get_node("Player Body")
			if best_p:
				Target = best_p
	move_and_slide()

func get_nearest_goal():
	if Target == null:
		return Vector2()
	var p1 = Target.global_position + Vector2(300, -100)
	var p2 = Target.global_position + Vector2(-300, -100)
	if p1.distance_to(global_position) < p2.distance_to(global_position):
		return p1
	return p2

func attack():
	print("kaboom")

func get_hit(dmg, direction):
	velocity += 50*dmg*direction
	hp -= dmg
	action_cd = max_action_cd
	is_moving = false
	if hp <= 0:
		death_timer = timer
		is_dead = true
