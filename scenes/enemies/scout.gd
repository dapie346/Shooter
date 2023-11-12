extends CharacterBody2D

signal laser(pos, direction)

var player_nearby: bool = false
var can_laser: bool = true
var pos: Vector2
var direction: Vector2
@onready var particle_markers = $LaserSpawnPositions.get_children()
var particle_start_position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	direction = (Globals.player_pos - position).normalized()
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			particle_start_position = particle_markers[randi() % particle_markers.size()]
			pos = particle_start_position.global_position
			laser.emit(pos, direction)
			can_laser = false
			$LaserCooldown.start()


func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_cooldown_timeout():
	can_laser = true
