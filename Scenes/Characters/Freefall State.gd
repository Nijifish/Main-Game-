extends State
class_name FreefallState

var BUFFER_TIME : float
var LANDING_TIME : float

#var PEAK_HEIGHT : float = 200.0
#var TIME_FOR_PEAK_HEIGHT : float = sqrt((2*PEAK_HEIGHT)/6000)
#var INITIAL_Y_VELOCITY : float = -(2*PEAK_HEIGHT)/TIME_FOR_PEAK_HEIGHT

func Enter():
	Player.velocity.y = Player.INITIAL_Y_VELOCITY

func Update(delta):
	
	if Player.TIME_ELAPSED < Player.TIME_FOR_PEAK_HEIGHT:
		Player.GRAVITY = 6000
	else:
		Player.GRAVITY = 7000
	
	
	Player.TIME_ELAPSED += delta
	Player.velocity.y = Player.GRAVITY * Player.TIME_ELAPSED + Player.INITIAL_Y_VELOCITY
	
	
func PhysicsUpdate(delta):
	if Player.is_on_floor():
		LANDING_TIME = Player.TIME_ELAPSED
		if LANDING_TIME - BUFFER_TIME <= Player.TIME_FOR_PEAK_HEIGHT/6:
			Player.JUMP_BUFFER = true
			LANDING_TIME = 0
			BUFFER_TIME = 0
			
		Transitioned.emit(self, "Ground State")
		
	if Input.is_action_just_released("jump"):
		if Player.TIME_ELAPSED == Player.TIME_FOR_PEAK_HEIGHT/2:
			Player.TIME_ELAPSED = Player.TIME_FOR_PEAK_HEIGHT

	if Input.is_action_just_pressed("jump"):
		BUFFER_TIME = Player.TIME_ELAPSED
