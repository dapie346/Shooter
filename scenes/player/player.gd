extends CharacterBody2D

@export var speed: int = 500
var can_laser: bool = true
var can_grenade: bool = true

signal laser(pos, direction)
signal grenade(pos, direction)

func _process(_delta):
	#move input
	var move_direction = Input.get_vector("left", "right", "up", "down")
	velocity = move_direction * speed
	move_and_slide()
	
	#rotate player
	look_at(get_global_mouse_position())
	
	#determine directions
	var pointing_direction = (get_global_mouse_position() - position).normalized()
	var particle_markers = $ParticleStartPositions.get_children()
	var particle_start_position = particle_markers[randi() % particle_markers.size()]
	var pos = particle_start_position.global_position
	
	#shooting input
	if Input.is_action_pressed("primary_action") and can_laser:
		can_laser = false
		$LaserTimer.start()
		laser.emit(pos, pointing_direction)
		
	#grenade input
	if Input.is_action_pressed("secondary_action") and can_grenade:
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit(pos, pointing_direction)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
