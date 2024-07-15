extends State

func Enter():
	Player.Sprite.play("FREEFALL_ANIMATION")
	Player.GRAVITY = 6000
	Player.TIME_ELAPSED = Player.TIME_FOR_PEAK_HEIGHT
	
func Exit():
	pass

func Update(_delta: float):
	Player.TIME_ELAPSED += _delta
	if Player.TIME_ELAPSED <= 2 * Player.TIME_FOR_PEAK_HEIGHT:
		Player.velocity.y = Player.GRAVITY * Player.TIME_ELAPSED + Player.INITIAL_Y_VELOCITY
	else:
		Player.velocity.y = -Player.INITIAL_Y_VELOCITY
	
func PhysicsUpdate(_delta: float):
	if not Player.CayoteTimer.is_stopped():
		if Input.is_action_just_pressed("jump"):
			print("Transitioning from freefall to jump")
			Transitioned.emit(self, "JumpingState")
		if Player.is_on_floor():
			Player.CayoteTimer.stop()
	else:
		if Input.is_action_just_pressed("jump"):
			if get_parent().PREVIOUS_STATE != get_parent().STATES["DoubleJumpState".to_lower()] and not (Player.LeftBufferCheck.is_colliding() or Player.RightBufferCheck.is_colliding()):
				print("Transitioning from freefall to doublejump")
				Transitioned.emit(self, "DoubleJumpState")
				print("YESWAY")
			if Player.LeftBufferCheck.is_colliding() or Player.RightBufferCheck.is_colliding():
				print("Transitioning from freefall to buffer")
				Transitioned.emit(self, "BufferState")
				print("NOWAY")
				
		elif Player.is_on_floor():
			print("Transitioning from freefall to ground")
			Transitioned.emit(self, "GroundState")
			
		elif Player.is_on_wall() and not Player.is_on_floor():
			print("Transitioning from freefall to wallslide")
			Transitioned.emit(self, "WallSlideState")

