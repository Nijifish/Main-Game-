extends State

func Enter():
	Player.Sprite.play("JUMP_ANIMATION")
	Player.GRAVITY = 6000
	Player.TIME_ELAPSED = 0
	Player.MOVE_ACCELARATION = 100
	if Player.left_wall():
		Player.velocity.x = 1000
	elif Player.right_wall():
		Player.velocity.x = -1000

func Exit():	
	Player.MOVE_ACCELARATION = 300

func Update(_delta: float):
	Player.TIME_ELAPSED += 1.25*_delta
	Player.velocity.y = Player.GRAVITY * Player.TIME_ELAPSED + Player.INITIAL_Y_VELOCITY
	#if Player.left_wall():
		#Player.velocity.x = 1000
	#elif Player.right_wall():
		#Player.velocity.x = -1000

func PhysicsUpdate(_delta: float):
	if Player.is_on_wall() and not Player.is_on_floor():
		Transitioned.emit(self, "WallSlideState")
	elif Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, "DoubleJumpState")
	elif Player.TIME_ELAPSED >= Player.TIME_FOR_PEAK_HEIGHT and not Player.is_on_wall():
		Transitioned.emit(self, "FreefallState")
