extends Node

func _ready() -> void:
	print("Starting DiscordRCPzz")
	DiscordRPC.app_id = 1500535153070440721
	DiscordRPC.details = "An Undertale fan game!"
	DiscordRPC.state = "Menu"
	DiscordRPC.is_public_party = false
	DiscordRPC.max_party_size = 1
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.large_image = "soul_large"
	DiscordRPC.large_image_text = "Made by Honeydev, Morro, and Mr. Coconut. Credits to Toby Fox for Undertale! Not finished yet!"
	DiscordRPC.refresh() # Always refresh after changing the values!

func _physics_process(delta: float) -> void:
	DiscordRPC.run_callbacks()
