extends CharacterBody2D

var speed = 200
@onready var player = get_tree().get_first_node_in_group("player_soul")


var left = false
var right = false
var up = false
var down = false

var touching_player = false

var attack_id = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().get_first_node_in_group("root").attacks[get_tree().get_first_node_in_group("root").attacks_id] == "left":
		left = true
		right = false
		down = false
		up = false
		print("left")
	if get_tree().get_first_node_in_group("root").attacks[get_tree().get_first_node_in_group("root").attacks_id] == "up":
		left = false
		right = false
		down = false
		up = true
		print("up")
	if get_tree().get_first_node_in_group("root").attacks[get_tree().get_first_node_in_group("root").attacks_id] == "right":
		left = false
		right = true
		down = false
		up = false
		print("right")
	if get_tree().get_first_node_in_group("root").attacks[get_tree().get_first_node_in_group("root").attacks_id] == "down":
		left = false
		right = false
		down = true
		up = false
		print("down")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if left:
		attack_id+=1
		if player.facing_left and touching_player:
			queue_free()
			print("yay")
		elif touching_player and !player.facing_left:
			queue_free()
			print("wrong")
			player.active_health -= 3
	elif right:
		attack_id+=1
		if player.facing_right and touching_player:
			queue_free()
			print("yay")
		elif touching_player and !player.facing_right:
			print("wrong")
			player.active_health -= 3
			queue_free()
	elif up:
		attack_id+=1
		if player.facing_up and touching_player:
			queue_free()
			print("yay")
		elif touching_player and !player.facing_up:
			queue_free()
			print("wrong")
			player.active_health -= 3
	elif down:
		attack_id+=1
		if player.facing_down and touching_player:
			queue_free()
			print("yay")
		elif touching_player and !player.facing_down:
			queue_free()
			print("wrong")
			player.active_health -= 3
	
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()


		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_soul"):
		touching_player = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player_soul"):
		touching_player = false
