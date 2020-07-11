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
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("move_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
			
	motion = move_and_slide(motion, UP)
	pass

#Player death
func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	die()

func die() -> void:
	PlayerData.deaths += 1
	queue_free()
	
func _on_SocialDistance_body_entered(body: Node) -> void:
	die()

var _velocity: = Vector2.ZERO
export var stomp_impulse: = 600.0
export var speed: = Vector2(300.0, 1000.0)

#Player bounce off enemy
#func _on_EnemyDetector_area_entered(area: Area2D) -> void:
#	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)
	
#Player bounce on bumper
func _on_BumperDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func calculate_stomp_velocity(linear_velocity: Vector2, stomp_impulse: float) -> Vector2:
	var stomp_jump: = -speed.y if Input.is_action_pressed("jump") else -stomp_impulse
	return Vector2(linear_velocity.x, stomp_jump)





