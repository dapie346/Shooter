extends CharacterBody2D
class_name Enemy

@export var health: int
var player_nearby: bool = false
var vulnerable: bool = true


func hit(damage: int) -> void:
	if vulnerable:
		vulnerable = false
		$Timers/HitTimer.start()
		$Particles/HitParticles.emitting = true
		hit_shader_on()
		health -= damage
		if health <= 0:
			death()

func death():
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _on_hit_timer_timeout():
	vulnerable = true
	hit_shader_off()
	
func hit_shader_on():
	$EnemySprite.material.set_shader_parameter("progress", 0.8)
	
func hit_shader_off():
	$EnemySprite.material.set_shader_parameter("progress", 0)
