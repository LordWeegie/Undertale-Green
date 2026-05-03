extends CharacterBody2D

#speed
# const SPEED = 150.0
@export var active_health : int = 20
@export var health_max : int = 20
@export var health_label : Label

# Check where facing variables
var facing_down = false
var facing_up = true
var facing_left = false
var facing_right = false
#movement
func movement():
	if Input.is_action_just_pressed("select"):
		active_health -= 3
		print(active_health)
	if Input.is_action_just_pressed("down"):
		facing_down = true
		facing_left = false
		facing_right = false
		facing_up = false
	if Input.is_action_just_pressed("up"):
		facing_up = true
		facing_down = false
		facing_left = false
		facing_right = false
	if Input.is_action_just_pressed("left"):
		facing_up = false
		facing_down = false
		facing_right = false
		facing_left = true
	if Input.is_action_just_pressed("right"):
		facing_down = false
		facing_up = false
		facing_left = false
		facing_right = true
	#var input_direction = Input.get_vector("left", "right", "up", "down")
	#velocity = input_direction * SPEED
	
#calling functions!
func _physics_process(_delta: float) -> void:
	if facing_down:
		print("Looking down")
	elif facing_up:
		print("Looking up")
	elif facing_right:
		print("Looking right")
	elif facing_left:
		print("Looking left")
	movement()
	move_and_slide()
	check_health()

func check_health():
	if active_health <= 0:
		get_tree().reload_current_scene()
	health_label.text = "Health: " + str(active_health) + "/" + str(health_max)
#animation for later
