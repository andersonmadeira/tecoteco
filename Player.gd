extends KinematicBody2D

signal crashed

const UP = Vector2(0, -1)
const FLAP = 400
const MAX_FALL_SPEED = 200
const GRAVITY = 10

var velocity = Vector2()
var playing = true

func _ready():
	resume()
	pass

func _physics_process(delta):
	velocity.y += GRAVITY
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
	
	if playing and Input.is_action_just_pressed("flap"):
		velocity.y -= FLAP
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		emit_signal("crashed")
		stop()
		
		
func stop():
	playing = false
	$AnimatedSprite.playing = false
	
func resume():
	playing = true
	$AnimatedSprite.playing = true
		
#	velocity = move_and_slide(velocity, Vector2.UP)
#
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		print("I collided with ", collision.collider.name)
#		crashed = true
#		$AnimatedSprite.playing = false
