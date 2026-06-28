extends Node2D

@export var attacks : Array[String]
@export var delay : float = 1.0
var attacks_id : int = 0
@export var can_attack : bool = true

@onready var bullet_scene = preload("res://scene/players/bullet.tscn")

@export var start_left = false
@export var start_right = false
@export var start_up = false
@export var start_bottom = false

var cooldown = false

func _ready():
	attack_cooldown()
	cooldown = true

func attack():
	if attacks_id > attacks.size() - 1:
		can_attack = false
		return
	if attacks[attacks_id] == "left":
		print("Left")
		start_left = true
		start_right = false
		start_up = false
		start_bottom = false
		var bullet = bullet_scene.instantiate()
		
		bullet.global_position = $left_bullet_pos.global_position
		
		add_child(bullet)
		
	elif attacks[attacks_id] == "right":
		print("Right")
		start_left = false
		start_right = true
		start_up = false
		start_bottom = false
		var bullet = bullet_scene.instantiate()
		
		bullet.global_position = $right_bullet_pos.global_position
		
		add_child(bullet)

	elif attacks[attacks_id] == "up":
		print("Up")
		start_left = false
		start_right = false
		start_up = true
		start_bottom = false
		var bullet = bullet_scene.instantiate()
		
		bullet.global_position = $top_bullet_pos.global_position
		
		add_child(bullet)

	elif attacks[attacks_id] == "down":
		print("Down")
		start_left = false
		start_right = false
		start_up = false
		start_bottom = true
		var bullet = bullet_scene.instantiate()
		
		bullet.global_position = $bottom_bullet_pos.global_position
		
		add_child(bullet)

	attacks_id += 1
	cooldown = true
	attack_cooldown()

func _physics_process(delta: float) -> void:
	if can_attack and not cooldown:
		attack()
	else:
		return
		
func attack_cooldown():
	await get_tree().create_timer(delay).timeout
	cooldown = false
