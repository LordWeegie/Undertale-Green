extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DiscordRPC.state = "Prototype level!"
	DiscordRPC.refresh()

func _physics_process(delta: float) -> void:
	DiscordRPC.run_callbacks()
