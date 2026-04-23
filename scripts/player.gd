extends CharacterBody2D

#speed
const SPEED = 150.0

#movement
func movement():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED
	
#calling functions!
func _physics_process(_delta: float) -> void:
	movement()
	move_and_slide()
	
#animation for later
