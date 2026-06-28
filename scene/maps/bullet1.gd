extends ColorRect

const SPEED = 20

var bullet : String = "Bullet"
var bullet_damage = 10
var is_damaging : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_bulletspawn()

func _bulletspawn():
	move_toward(0.4, 100.9, SPEED)
