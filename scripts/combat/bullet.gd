extends CharacterBody2D

var speed = 200
@onready var player = get_tree().get_first_node_in_group("player_soul")

var attack_direction = ""
var delay = 0.1

var touching_player = false
var touch_timer = 0.0
var has_checked = false

func _ready():
	# Get the parent combat controller
	var combat_controller = get_parent()
	
	# Read the attack data directly from the controller's variables
	attack_direction = combat_controller.attack_direction
	delay = combat_controller.attack_delay
	
	print("Bullet: ", attack_direction, " | Delay: ", delay)

func _process(delta):
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
	
	if touching_player and not has_checked:
		touch_timer += delta
		print("Touch timer: ", touch_timer)
		if touch_timer >= delay:
			print("Timer reached delay! Checking direction...")
			check_direction()
			has_checked = true

func check_direction():
	print("=== check_direction() called ===")
	print("attack_direction = '", attack_direction, "'")
	
	var facing_correct = false
	
	match attack_direction:
		"left":
			facing_correct = player.facing_left
			print("Player facing_left = ", player.facing_left)
		"right":
			facing_correct = player.facing_right
			print("Player facing_right = ", player.facing_right)
		"up":
			facing_correct = player.facing_up
			print("Player facing_up = ", player.facing_up)
		"down":
			facing_correct = player.facing_down
			print("Player facing_down = ", player.facing_down)
		_:
			print("ERROR: Unknown direction! attack_direction = '", attack_direction, "'")
	
	print("facing_correct = ", facing_correct)
	
	if facing_correct:
		print("✅ Blocked! Deleting bullet.")
		queue_free()
	else:
		print("❌ Hit! Dealing 3 damage and deleting bullet.")
		player.active_health -= 3
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player_soul"):
		touching_player = true
		print("touching_player = true")

func _on_area_2d_body_exited(body):
	if body.is_in_group("player_soul"):
		touching_player = false
		touch_timer = 0.0
		print("touching_player = false, touch_timer reset")
