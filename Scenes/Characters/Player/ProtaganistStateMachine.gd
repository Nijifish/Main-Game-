extends Node
class_name ProtaganistStateMachine

@export var INITIAL_STATE : State
@export var Player : CharacterBody2D
@export var PREVIOUS_STATE : State

var CURRENT_STATE : State
var STATES : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			STATES[child.name.to_lower()] = child
			child.Player = Player
			child.Transitioned.connect(on_child_transition)
			
		if INITIAL_STATE:
			CURRENT_STATE = INITIAL_STATE
			PREVIOUS_STATE = CURRENT_STATE
			
func _process(delta):
	if CURRENT_STATE:
		CURRENT_STATE.Update(delta)
	
func _physics_process(delta):
	if CURRENT_STATE:
		CURRENT_STATE.PhysicsUpdate(delta)
		
func on_child_transition(state, NEW_STATE_NAME):
	if state != CURRENT_STATE:
		return
		
	var NEW_STATE = STATES.get(NEW_STATE_NAME.to_lower())
	if !NEW_STATE:
		return
		
	if CURRENT_STATE:
		PREVIOUS_STATE = CURRENT_STATE
		CURRENT_STATE.Exit()
		
	NEW_STATE.Enter()
	CURRENT_STATE = NEW_STATE
