extends State

func Enter():
	Player.Sprite.play("JUMP_ANIMATION")
	Player.GRAVITY = 5000
	Player.TIME_ELAPSED = 0
	
func Exit():
	pass

func Update(_delta: float):
	Player.TIME_ELAPSED += _delta
	Player.velocity.y = Player.GRAVITY * Player.TIME_ELAPSED + Player.INITIAL_Y_VELOCITY
	
func PhysicsUpdate(_delta: float):
	if Input.is_action_just_pressed("jump"):
		print("Transitioning from jump to doublejump")
		Transitioned.emit(self, "DoubleJumpState")
	elif Player.TIME_ELAPSED >= Player.TIME_FOR_PEAK_HEIGHT or Player.is_on_ceiling():
		print("Transitioning from jump to freefall")
		Transitioned.emit(self, "FreefallState")
	elif Player.is_on_wall() and Player.TIME_ELAPSED >= Player.TIME_FOR_PEAK_HEIGHT/2 and (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
		print("Transitioning from jump to wallslide")
		Transitioned.emit(self, "WallSlideState")
	
	
