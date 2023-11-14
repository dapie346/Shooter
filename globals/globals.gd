extends Node

signal stat_change

var player_vulnerable: bool = true
var player_pos: Vector2

var laser_amount: int = 20:
	set(value):
		laser_amount = value
		stat_change.emit()
var grenade_amount: int = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()
var max_health: int = 200:
	set(value):
		max_health = value
		stat_change.emit()
var health: int = 80:
	set(value):
		if value < health:
			health = min(value, max_health)
		else:
			if player_vulnerable:
				health = value
				player_vulnerable = false
				player_invulnerable_timer()
		stat_change.emit()

func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true
