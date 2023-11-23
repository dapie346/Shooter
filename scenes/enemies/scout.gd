extends Enemy

signal laser(pos, direction)

var can_laser: bool = true
var right_gun_use: bool = true

func _ready():
	health = 50
	
func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var marker_node = $LaserSpawnPositions.get_child(right_gun_use)
			right_gun_use = not right_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserTimer.start()

func _on_laser_timer_timeout():
	can_laser = true


func _on_notice_area_body_entered(body):
	if body.is_in_group('Player'):
		player_nearby = true


func _on_notice_area_body_exited(body):
	if body.is_in_group('Player'):
		player_nearby = false
