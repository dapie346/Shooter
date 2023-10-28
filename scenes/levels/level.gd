extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body):
	if body == $Player:
		print("player has entered")

func _on_player_laser(pos):
	var laser = laser_scene.instantiate()
	laser.position = pos
	$Projectiles.add_child(laser)

func _on_player_grenade(pos):
	var grenade = grenade_scene.instantiate()
	grenade.position = pos
	$Projectiles.add_child(grenade)
