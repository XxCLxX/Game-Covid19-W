#extends Actor
#
#func _physics_process(_delta: float) -> void:
#	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
#	var direction: = get_direction()
#	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
#	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
#
#func get_direction() -> Vector2:
#	return Vector2(
#		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
#		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
#	)
#
#func calculate_move_velocity(
#		linear_velocity: Vector2, 
#		direction: Vector2,
#		speed: Vector2,
#		is_jump_interrupted: bool
#	) -> Vector2:
#	var out: = linear_velocity
#	out.x = speed.x * direction.x
#	out.y += gravity * get_physics_process_delta_time()
#	if direction.y == -1.0:
#		out.y = speed.y * direction.y
#		if is_jump_interrupted:
#			out.y = 0.0
#	return out
#
##Player's death
#func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
#	die()
#func die() -> void:
#	PlayerData.deaths += 1
#	queue_free()

extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 800
const JUMP_HEIGHT = -780
var motion = Vector2()

#Player's movements
func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("move_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$player.flip_h = false
		$player.play("Run")
	elif Input.is_action_pressed("move_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$player.flip_h = true
		$player.play("Run")
	else:
		$player.play("Idle")
		friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$player.play("Jump")
		else:
			$player.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
			
	motion = move_and_slide(motion, UP)
	pass
	
#Player's death
func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	die()

func die() -> void:
	PlayerData.deaths += 1
	queue_free()
