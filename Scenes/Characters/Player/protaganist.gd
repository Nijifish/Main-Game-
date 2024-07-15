extends CharacterBody2D

# Getting Children
@onready var Sprite = $AnimatedSprite2D
@onready var LeftBufferCheck = $LeftBufferCheck
@onready var RightBufferCheck = $RightBufferCheck
@onready var CayoteTimer = $CayoteTimer

# Movement Parameters
var MOVE_SPEED : float = 500
var DIRECTION : Vector2 = Vector2.ZERO
var GRAVITY : float = 5000
var PEAK_HEIGHT : float = 300.0
var TIME_ELAPSED : float = 0
var TIME_FOR_PEAK_HEIGHT : float = sqrt((2*PEAK_HEIGHT)/GRAVITY)
var INITIAL_Y_VELOCITY : float = -(2*PEAK_HEIGHT)/TIME_FOR_PEAK_HEIGHT

func _physics_process(_delta):
	DIRECTION = Input.get_vector("left", "right", "up", "down")
	print(DIRECTION)
	if DIRECTION == Vector2.RIGHT:
		velocity.x = move_toward(velocity.x, 500, MOVE_SPEED)
	elif DIRECTION == Vector2.LEFT:
		velocity.x = move_toward(velocity.x, -500, MOVE_SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE_SPEED)

	move_and_slide()
	flip_direction()
	
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#print("I collided with ", collision.get_normal())
		#print(position.x)
	
func flip_direction():
	if DIRECTION.x > 0:
		Sprite.flip_h = false
	elif DIRECTION.x < 0:
		Sprite.flip_h = true
		
	
func left_wall() -> bool:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var vec : Vector2 = Vector2.RIGHT
		if collision.get_normal() == vec:
			return true
	return false

func right_wall() -> bool:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var vec : Vector2 = Vector2.LEFT
		if collision.get_normal() == vec:
			return true
	return false
