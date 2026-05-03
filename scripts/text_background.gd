extends CanvasLayer

@export var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextBackground.scale = Vector2(12.0, 8.0)  # Or even higher
	$TextBackground.position = Vector2(get_viewport().get_visible_rect().size.x / 2, get_viewport().get_visible_rect().size.y - 10000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if camera:
		$TextBackground.position = Vector2(get_viewport().get_visible_rect().size.x / 2, get_viewport().get_visible_rect().size.y - 50)


func _on_check_player_bottom_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("text 2")
		offset = Vector2(39.48, -450.5)

func _on_check_player_top_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("text 1")
		offset = Vector2(39.48, -88.5)
