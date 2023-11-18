extends RigidBody2D

@export var damage: int = 20
@export var speed: int = 1000
var explosion_active: bool = false
var explosion_radius: int = 400

func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group('Containers') + get_tree().get_nodes_in_group('Entities')
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if target.has_method("hit") and in_range:
				target.hit(damage)


func explode():
	$AnimationPlayer.play("Explosion")
	$ExplosionTimer.start()
	explosion_active = true


func _on_explosion_timer_timeout():
	explosion_active = false
