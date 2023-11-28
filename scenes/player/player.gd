extends CharacterBody2D

@export var max_speed: int = 500
var can_laser: bool = true
var can_grenade: bool = true

signal laser(pos, direction)
signal grenade(pos, direction)

func _process(_delta):
	var move_direction = Input.get_vector("left", "right", "up", "down")
	velocity = move_direction * max_speed
	move_and_slide()
	Globals.player_pos = global_position
	
	look_at(get_global_mouse_position())
	
	var pointing_direction = (get_global_mouse_position() - position).normalized()
	var particle_markers = $ParticleStartPositions.get_children()
	var particle_start_position = particle_markers[randi() % particle_markers.size()]
	var pos = particle_start_position.global_position
	
	if Input.is_action_pressed("primary_action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		can_laser = false
		$Timers/LaserTimer.start()
		$GunfireParticles.emitting = true
		laser.emit(pos, pointing_direction)
		
	if Input.is_action_pressed("secondary_action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$Timers/GrenadeTimer.start()
		grenade.emit(pos, pointing_direction)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
	
func hit(damage: int):
	$Timers/HitTimer.start()
	$Particles/HitParticles.emitting = true
	$HitSound.play()
	hit_shader_on()
	Globals.health -= damage
	if Globals.health <= 0:
		death()

func hit_shader_on():
	$PlayerImage.material.set_shader_parameter("progress", 0.8)
	
func hit_shader_off():
	$PlayerImage.material.set_shader_parameter("progress", 0)
	
func death():
	$PlayerImage.visible = false
	$Particles/HitParticles.scale = Vector2(5.0, 5.0)
	TransitionLayer.game_over()
	await get_tree().create_timer(1.0).timeout
	var ui = get_parent().get_node("UI")
	if ui:
		ui.visible = false
	Music.queue_free()
	queue_free()

func _on_hit_timer_timeout():
	hit_shader_off()
