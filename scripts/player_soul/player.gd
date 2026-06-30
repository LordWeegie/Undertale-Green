extends CharacterBody2D

#speed
const SPEED = 150.0

var is_alive = true

@export var active_health : int = 20
@export var health_max : int = 20
@export var health_label : Label

# Check where facing variables
@export var facing_down = false
@export var facing_up = true
@export var facing_left = false
@export var facing_right = false
#movement
func movement():
	if Input.is_action_just_pressed("select"):
		active_health -= 3
		print(active_health)
	if Input.is_action_just_pressed("left"):
		facing_down = false
		facing_left = true
		facing_right = false
		facing_up = false

	elif Input.is_action_just_pressed("right"):
		facing_up = false
		facing_down = false
		facing_left = false
		facing_right = true

	elif Input.is_action_just_pressed("up"):
		facing_up = true
		facing_down = false
		facing_right = false
		facing_left = false

	elif Input.is_action_just_pressed("down"):
		facing_down = true
		facing_up = false
		facing_left = false
		facing_right = false
		
	#var input_direction = Input.get_vector("left", "right", "up", "down")
	#velocity = input_direction * SPEED
	
#calling functions!
func _physics_process(_delta: float) -> void:
	if facing_down:
		$AnimatedSprite2D.frame = 3
	if facing_up:
		$AnimatedSprite2D.frame = 0
	if facing_right:
		$AnimatedSprite2D.frame = 1
	if facing_left:
		$AnimatedSprite2D.frame = 2
	movement()
	move_and_slide()
	check_health()

func check_health():
	if active_health <= 0:
		is_alive = false
		get_tree().reload_current_scene()
	health_label.text = "HP: " + str(active_health) + "/" + str(health_max)
#animation for later
