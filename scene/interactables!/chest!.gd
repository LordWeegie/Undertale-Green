extends StaticBody2D

#the chest is a simple peace of interactable, you use it, it gives you an item based off chance
#chance related materials / var chances on object spawns?

var sword : String = "Sword"
var healing_bottle : String = "Healing bottle"
var beef : String = "Beef"


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("select"):
		$Sprite2D.play("interacted")
		print("sword")
