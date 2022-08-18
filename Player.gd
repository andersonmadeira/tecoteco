extends KinematicBody2D

const UP = Vector2(0, -1)
const FLAP = 400
const MAX_FALL_SPEED = 200
const GRAVITY = 10

var motion = Vector2()

func _ready():
	pass

func _physics_process(delta):
	motion.y += GRAVITY
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
	
	if Input.is_action_just_pressed("flap"):
		motion.y -= FLAP
		
	motion = move_and_slide(motion, UP)
