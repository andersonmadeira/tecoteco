extends KinematicBody2D

signal crashed

const UP = Vector2(0, -1)
const FLAP = 400
const MAX_FALL_SPEED = 200
const GRAVITY = 10

var velocity = Vector2()
var is_playing = true

#func _ready():
#	resume()
#	pass

func _physics_process(delta):
	if not is_playing:
		return
		
	velocity.y += GRAVITY
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
	
	if Input.is_action_just_pressed("flap"):
		velocity.y -= FLAP
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		emit_signal("crashed")
		stop()
		
func stop():
	is_playing = false
	$AnimatedSprite.playing = false
		
#	velocity = move_and_slide(velocity, Vector2.UP)
#
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		print("I collided with ", collision.collider.name)
#		crashed = true
#		$AnimatedSprite.playing = false
