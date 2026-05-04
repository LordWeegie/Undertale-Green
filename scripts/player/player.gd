extends CharacterBody2D

var speed = 100
@export var walking_speed = 100
@export var running_speed = 200
@export var text_background : Sprite2D
@export var dialogue_box : Label
@onready var raycast = $RayCast2D
@export var stamina_bar : AnimatedSprite2D
var is_talking = false
var moving_up_or_down = false
var can_move = true
var text_skip = false
var can_run = true
var is_stamina_draining = false
var stamina_running = false
var time_passed = 0
# Signals
signal continue_text_signal

# final text check variable
var final_text = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select") and is_talking:
		continue_text_signal.emit()
	movement(delta)
	set_raycast()
	check_raycast()
	if not is_talking and stamina_running == false:
		stamina(delta)

func wait_text_final():
	if final_text == true and is_talking == true:
		await get_tree().create_timer(0.01).timeout
		final_text = false
		print(final_text)
		if final_text == false:
			is_talking = false
func check_raycast():
	if is_talking == false:
		text_background.visible = false
		dialogue_box.text = ""
	# a LOT of the dialogue code
	if raycast.is_colliding(): 
		if raycast.get_collider().is_in_group("npc"):
			if Input.is_action_just_pressed("select") and is_talking == false and final_text == false:
				can_move = false
				text_background.visible = true
				is_talking = true
				# For loop of each dialogue line
				for i in range(raycast.get_collider().text.size()):
					if raycast.get_collider().text.size() == 1:
						final_text = true
					text_skip = false
					var letter = 0
					# For loop of each letter
					for j in range(len(raycast.get_collider().text[i])):
						if text_skip == false:
							letter = j
						else:
							letter = raycast.get_collider().text[i].length()
							break
						dialogue_box.text = raycast.get_collider().text[i].substr(0, letter + 1)
						await get_tree().create_timer(0.08).timeout
					if i < raycast.get_collider().text.size() -1:
						if text_skip == true:
							dialogue_box.text = raycast.get_collider().text[i].substr(0, letter + 1)
						final_text = true
						print(i)
						await continue_text_signal
					else:
						if text_skip == true:
							dialogue_box.text = raycast.get_collider().text[i].substr(0, letter + 1)
						await continue_text_signal
						wait_text_final()
				

			
func set_raycast():
	if can_move and !is_talking:
		if Input.is_action_pressed("right"):
			raycast.target_position = Vector2(13, 0)
		elif Input.is_action_pressed("left"):
			raycast.target_position = Vector2(-13, 0)
		elif Input.is_action_pressed("up"):
			raycast.target_position = Vector2(0, -13)
		elif Input.is_action_pressed("down"):
			raycast.target_position = Vector2(0, 13)

func play_stamina_animation():
	if speed > 100 and can_run:
		stamina_bar.visible = true
		stamina_bar.play()
		return true
	return false
	
func stamina(delta: float):
	if speed > 100 and velocity != Vector2(0.0, 0.0) and time_passed < 5.0:
		stamina_bar.play()
		print(time_passed)
		time_passed += delta
		if time_passed >= 4.4:
			print("Test")
			can_run = false
			stamina_bar.stop()
			await get_tree().create_timer(3.0).timeout
			can_run = true
			time_passed = 0
func movement(delta: float):
	if is_talking == true:
		if Input.is_action_just_pressed("x"):
			text_skip = true
	if is_talking == true:
		can_move = false
	# Sprinting system
	if Input.is_action_pressed("x") and can_run:
		speed = running_speed
		$Sprite.speed_scale = 1.5
	elif !Input.is_action_pressed("x"):
		speed = walking_speed
		$Sprite.speed_scale = 1.0
	if can_run == false:
		speed = walking_speed
	# Make sure the character isn't flipped when facing down
	if $Sprite.animation == "down":
		$Sprite.flip_h = false
	# Set can_move to true or false
	if Input.is_action_pressed("up") and Input.is_action_pressed("down") or Input.is_action_pressed("left") and Input.is_action_pressed("right"):
		can_move = false
	elif !is_talking:
		can_move = true
	# Move character
	if can_move:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		velocity = input_direction * speed
		if Input.is_action_pressed("down"):
			moving_up_or_down = true
		elif Input.is_action_pressed("up"):
			moving_up_or_down = true
		else: 
			moving_up_or_down = false
			
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
	move_and_slide()
