extends CharacterBody2D

@export var speed: int = 500
var can_laser: bool = true
var can_grenade: bool = true

signal laser
signal grenade

func _process(_delta):
	#move input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	#rotate player
	look_at(get_global_mouse_position())
	
	#shooting input
	if Input.is_action_pressed("primary_action") and can_laser:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$LaserTimer.start()
		laser.emit(selected_laser.global_position)
		
	#grenade input
	if Input.is_action_pressed("secondary_action") and can_grenade:
		var grenade_markers = $GrenadeStartPositions.get_children()
		var selected_grenade = grenade_markers[randi() % grenade_markers.size()]
		can_grenade = false
		$GrenadeTimer.start()
		grenade.emit(selected_grenade.global_position)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
