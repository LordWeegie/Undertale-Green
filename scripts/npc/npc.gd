extends CharacterBody2D

@export var text: Array[String]
@export var is_talking = false
@export var question_count := 0
@export var dialogue_line := 0
@export var question_position : Array[int] = []
func _ready() -> void:
	print(text)

func _physics_process(delta: float) -> void:
	if is_talking == true:
		pass
