extends CharacterBody2D

# Getting Children
@onready var sprite = $AnimatedSprite2D


const SPEED = 500.0
#const JUMP_VELOCITY = -400.0
var DIRECTION : Vector2 = Vector2.ZERO

var GRAVITY : float = 6000
var JUMP_BUFFER : bool = false

var PEAK_HEIGHT : float = 300.0
var TIME_ELAPSED : float = 0
var TIME_FOR_PEAK_HEIGHT : float = sqrt((2*PEAK_HEIGHT)/GRAVITY)
var INITIAL_Y_VELOCITY : float = -(2*PEAK_HEIGHT)/TIME_FOR_PEAK_HEIGHT

func _physics_process(delta):
	DIRECTION = Input.get_vector("left", "right", "up", "down")
	if DIRECTION:
		velocity.x = DIRECTION.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	flip_direction()
	#animation_player()
	
func flip_direction():
	if DIRECTION.x > 0:
		sprite.flip_h = false
	elif DIRECTION.x < 0:
		sprite.flip_h = true
		
#func animation_player():
	#if velocity.x == 0 and is_on_floor():
		#sprite.play("idle")
	#else:
		#sprite.play("walk")
		#
