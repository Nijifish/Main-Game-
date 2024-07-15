extends State
class_name GroundState

func Enter():
	Player.sprite.play("idle")
	
func PhysicsUpdate(delta):
	if Input.is_action_just_pressed("jump") or Player.JUMP_BUFFER:
		Player.TIME_ELAPSED = 0
		Player.JUMP_BUFFER = false
		Transitioned.emit(self, "Freefall State")
	elif not Player.is_on_floor():
		Player.TIME_ELAPSED = Player.TIME_FOR_PEAK_HEIGHT
		Transitioned.emit(self, "Freefall State")

