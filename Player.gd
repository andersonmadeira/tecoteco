extends KinematicBody2D

signal crashed
signal start_game
signal collected_star

const UP = Vector2(0, -1)
const FLAP = 400
const MAX_FALL_SPEED = 200
const GRAVITY = 10

var velocity = Vector2()
var is_playing = false
var crashed = false

func _process(delta):
	if not is_playing and not crashed and Input.is_action_just_pressed("flap"):
		emit_signal("start_game")

func _physics_process(delta):
	if not is_playing:
		return
		
	velocity.y += GRAVITY
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
	
	if Input.is_action_just_pressed("flap"):
		$SoundJump.play()
		velocity.y -= FLAP
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		$SoundHit.play()
		crashed = true
		emit_signal("crashed")
		stop()
		
func stop():
	is_playing = false
	$AnimatedSprite.playing = false
	
func resume():
	crashed = false
	is_playing = true
	$AnimatedSprite.playing = true

func collect_star():
	$SoundCoin.play()
	emit_signal("collected_star")
		
