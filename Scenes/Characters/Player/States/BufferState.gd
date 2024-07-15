extends State

func Update(_delta: float):
	Player.TIME_ELAPSED += _delta
	Player.velocity.y = Player.GRAVITY * Player.TIME_ELAPSED + Player.INITIAL_Y_VELOCITY

func PhysicsUpdate(_delta: float):
	if Player.is_on_floor():
		print("Transitioning from buffer to ground")
		Transitioned.emit(self, "GroundState")
