extends Node2D

@export var player : CharacterBody2D
@export var camera : Camera2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = camera.get_screen_center_position()
