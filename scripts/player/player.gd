extends CharacterBody2D

var speed = 100
@export var walking_speed = 100
@export var running_speed = 150
@export var text_background : Sprite2D
@export var dialogue_box : Label
@onready var raycast = $RayCast2D
var is_talking = false
var moving_up_or_down = false
var can_move = true
var text_skip = false

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

func wait_text_final():
	if final_text == true and is_talking == true:
		await get_tree().create_timer(0.01).timeout
		final_text = false
		print(final_text)
		if final_text == false:
			print("hey")
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
				for i in range(raycast.get_collider().text.size()):
					text_skip = false
					var letter = 0
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
						print("wait text final")
						wait_text_final()
				

			
func set_raycast():
	if can_move and !is_talking:
		if Input.is_action_pressed("right"):
			raycast.target_position = Vector2(10, 0)
		elif Input.is_action_pressed("left"):
			raycast.target_position = Vector2(-10, 0)
		elif Input.is_action_pressed("up"):
			raycast.target_position = Vector2(0, -10)
		elif Input.is_action_pressed("down"):
			raycast.target_position = Vector2(0, 10)

func movement(delta: float):
	if is_talking == true:
		if Input.is_action_just_pressed("x"):
			text_skip = true
	if is_talking == true:
		can_move = false
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
	elif !is_talking:
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
	move_and_slide()
