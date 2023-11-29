extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready():
	
	Globals.current_level = get_name()
	
	if Globals.current_level in Globals.defeated_enemies:
		for enemy_name in Globals.defeated_enemies[Globals.current_level]:
			var enemy = find_node_by_name($Enemies, enemy_name)
			if enemy:
				enemy.queue_free()
	
	if Globals.current_level in Globals.opened_containers:
		for container_name in Globals.opened_containers[Globals.current_level]:
			var container = find_node_by_name($Objects/Containers, container_name)
			if container:
				container.open_lid()
	
	for container in get_tree().get_nodes_in_group('Containers'):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group('Scouts'):
		scout.connect("laser", _on_scout_laser)

func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred("add_child", item)

func _on_player_laser(pos, direction):
	create_laser(pos, direction)

func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	
func _on_scout_laser(pos, direction):
	create_laser(pos, direction)
	
func create_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)

func find_node_by_name(parent_node, name):
	for child in parent_node.get_children():
		if child.name == name:
			return child
	return null
