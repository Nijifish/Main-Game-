extends State

func Enter():
	Player.velocity.y = -Player.INITIAL_Y_VELOCITY/5

func PhysicsUpdate(_delta: float):
	if Player.is_on_floor():
		print("Transitioning from wallslide to ground")
		Transitioned.emit(self, "GroundState")
	elif Input.is_action_just_pressed("jump"):
		print("Transitioning from wallslide to walljump")		
		Transitioned.emit(self, "WallJumpState")
	elif not Player.is_on_wall():
		print("Transitioning from wallslide to freefall")		
		Transitioned.emit(self, "FreefallState")
