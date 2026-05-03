extends Node

func _ready() -> void:
	DiscordRPC.app_id = 1500535153070440721
	DiscordRPC.details = "An Undertale fan game!"
	DiscordRPC.state = "Menu"
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.refresh() # Always refresh after changing the values!

func _physics_process(delta: float) -> void:
	DiscordRPC.run_callbacks()
