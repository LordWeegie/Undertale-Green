extends Control

var start_selected : bool = true
var quit_selected : bool = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("down") and start_selected:
		quit_selected = true
		start_selected = false
	if Input.is_action_just_pressed("up") and quit_selected:
		quit_selected = false
		start_selected = true

	if quit_selected:
		$MarginContainer/VBoxContainer/Label.label_settings.font_color = Color(0, 1, 0)
		$MarginContainer/VBoxContainer/Label2.label_settings.font_color = Color(1, 1, 1)
	if start_selected:
		$MarginContainer/VBoxContainer/Label2.label_settings.font_color = Color(0, 1, 0)
		$MarginContainer/VBoxContainer/Label.label_settings.font_color = Color(1, 1, 1)
	if Input.is_action_just_pressed("select") and quit_selected:
		get_tree().quit()   
	if Input.is_action_just_pressed("select") and start_selected:
		get_tree().change_scene_to_file("res://scene/maps/prototype.tscn")
