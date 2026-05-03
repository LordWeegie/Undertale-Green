extends CharacterBody2D

#speed
const SPEED = 150.0
@export var active_health : int = 20
@export var health_max : int = 20
@export var health_label : Label
#movement
func movement():
	if Input.is_action_just_pressed("select"):
		active_health -= 3
		print(active_health)
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED
	
#calling functions!
func _physics_process(_delta: float) -> void:
	movement()
	move_and_slide()
	check_health()

func check_health():
	if active_health <= 0:
		get_tree().reload_current_scene()
	health_label.text = "Health: " + str(active_health) + "/" + str(health_max)
#animation for later
