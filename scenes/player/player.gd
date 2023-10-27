extends CharacterBody2D

@export var speed = 500
var can_laser: bool = true
var can_grenade: bool = true

func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_pressed("primary_action") and can_laser:
		print('shoot')
		can_laser = false
		
	if Input.is_action_pressed("secondary_action") and can_grenade:
		print('grenade')
		can_grenade = false
		


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
