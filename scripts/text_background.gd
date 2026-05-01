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
