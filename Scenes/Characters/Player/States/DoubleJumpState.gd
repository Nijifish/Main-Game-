extends State

func Enter():
	Player.Sprite.play("JUMP_ANIMATION")
	Player.GRAVITY = 6000
	Player.TIME_ELAPSED = 0
	
func Exit():
	pass

func Update(_delta: float):
	Player.TIME_ELAPSED += 1.25*_delta
	Player.velocity.y = Player.GRAVITY * Player.TIME_ELAPSED + Player.INITIAL_Y_VELOCITY
	
func PhysicsUpdate(_delta: float):
	if Player.TIME_ELAPSED >= Player.TIME_FOR_PEAK_HEIGHT or Player.is_on_ceiling():
		print("Transitioning from doublejump to freefall")
		Transitioned.emit(self, "FreefallState")
	elif Player.is_on_wall() and not Player.is_on_floor():
		print("Transitioning from doublejump to wallslide")
		Transitioned.emit(self, "WallSlideState")
	
