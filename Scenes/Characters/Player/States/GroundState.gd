extends State

func Enter():
	print("Welcome to Groundstate")
	
func Exit():
	pass

func Update(_delta: float):
	pass
	
func PhysicsUpdate(_delta: float):
	if Player.velocity.x == 0:
		Player.Sprite.play("IDLE_ANIMATION")
	elif Player.velocity.x != 0:
		Player.Sprite.play("WALK_ANIMATION")
		
	if Input.is_action_just_pressed("jump") or get_parent().PREVIOUS_STATE == get_parent().STATES["BufferState".to_lower()]:
		print("Transitioning from ground to jump")

		Transitioned.emit(self, "JumpingState")
		
	if not Player.is_on_floor() and not Input.is_action_just_pressed("jump"):
		Player.CayoteTimer.start()
		print("Transitioning from ground to freefall")
		Transitioned.emit(self, "FreefallState")
