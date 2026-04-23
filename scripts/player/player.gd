extends CharacterBody2D

var speed = 100
@export var walking_speed = 100
@export var running_speed = 150
var moving_up_or_down = false
var can_move = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)

func movement(delta: float):
	# Sprinting system
	if Input.is_action_pressed("x"):
		speed = running_speed
		$Sprite.speed_scale = 1.5
	elif !Input.is_action_pressed("x"):
		speed = walking_speed
		$Sprite.speed_scale = 1.0
	
	# Make sure the character isn't flipped when facing down
	if $Sprite.animation == "down":
		$Sprite.flip_h = false
	# Set can_move to true or false
	if Input.is_action_pressed("up") and Input.is_action_pressed("down") or Input.is_action_pressed("left") and Input.is_action_pressed("right"):
		can_move = false
	else:
		can_move = true
	# Move character
	if can_move:
		if Input.is_action_pressed("down"):
			position.y += speed * delta
			moving_up_or_down = true
		elif Input.is_action_pressed("up"):
			position.y -= speed * delta
			moving_up_or_down = true
		else: moving_up_or_down = false
		if Input.is_action_pressed("left"):
			position.x -= speed * delta
		if Input.is_action_pressed("right"):
			position.x += speed * delta
			
		if Input.is_action_pressed("right"):
			$Sprite.flip_h = false
		elif Input.is_action_pressed("left"):
			$Sprite.flip_h = true
	
	# Animate character
	if Input.is_action_pressed("left") and can_move or Input.is_action_pressed("right") and can_move:
		$Sprite.play("left_and_right")
	elif Input.is_action_pressed("down") and can_move:
		$Sprite.play("down")
	elif Input.is_action_pressed("up") and can_move:
		$Sprite.play("up")
	else:
		$Sprite.stop()
