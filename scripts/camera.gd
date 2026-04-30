extends Camera2D

# Export variables
@export var can_move_horizontal: bool = false
@export var can_move_vertical : bool = false
@export var player : CharacterBody2D

# Export limit variables
@export var limit_enable : bool = true
@export var left_limit : Node2D
@export var right_limit : Node2D
@export var top_limit : Node2D
@export var bottom_limit : Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set zoom
	zoom = Vector2(3.0, 3.0)
	
	# Set limits
	if can_move_horizontal and limit_enable:
		limit_left = left_limit.position.x
		limit_right = right_limit.position.x
	
	if can_move_vertical and limit_enable:
		limit_top = top_limit.position.y
		limit_bottom = bottom_limit.position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_move_horizontal:
		position.x = player.position.x
	if can_move_vertical:
		position.y = player.position.y
