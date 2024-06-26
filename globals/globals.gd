extends Node

signal stat_change

var game_completed: bool
var game_over: bool
var outside_left: bool
var outside_cleared: bool
var inside_cleared: bool
var player_vulnerable: bool
var current_level: String
var defeated_enemies = {}
var opened_containers = {}
var player_pos: Vector2

var laser_amount: int:
	set(value):
		laser_amount = value
		stat_change.emit()
var grenade_amount: int:
	set(value):
		grenade_amount = value
		stat_change.emit()
var max_health: int:
	set(value):
		max_health = value
		stat_change.emit()
var health: int:
	set(value):
		if value > health:
			health = min(value, max_health)
		else:
			if player_vulnerable:
				health = value
				player_vulnerable = false
				player_invulnerable_timer()
		stat_change.emit()

func set_default_values():
	game_completed = false
	game_over = false
	outside_left = false
	outside_cleared = false
	inside_cleared = false
	player_vulnerable = true
	laser_amount = 40
	grenade_amount = 1
	max_health = 200
	health = 200
	defeated_enemies.clear()
	opened_containers.clear()

func record_enemy_defeat(enemy: String):
	if current_level in defeated_enemies:
		defeated_enemies[current_level].append(enemy)
	else:
		defeated_enemies[current_level] = [enemy]

func record_opened_container(container: String):
	if current_level in opened_containers:
		opened_containers[current_level].append(container)
	else:
		opened_containers[current_level] = [container]

func check_for_victory():
	if outside_cleared and inside_cleared:
		game_completed = true
		game_finished()

func game_finished():
	Music.stop()
	TransitionLayer.change_scene("res://scenes/user interface/menu.tscn", "fade_medium")

func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true
