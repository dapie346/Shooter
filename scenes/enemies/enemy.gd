extends CharacterBody2D
class_name Enemy

@export var health: int
var player_nearby: bool = false
var vulnerable: bool = true
var alive: bool = true


func hit(damage: int) -> void:
	if vulnerable and alive:
		vulnerable = false
		$Timers/HitTimer.start()
		$HitSound.play()
		$Particles/HitParticles.emitting = true
		hit_shader_on()
		health -= damage
		if health <= 0:
			check_conditions()
			death()


func check_conditions():
	var level = get_parent().get_parent()
	if level != null:
		level.check_for_enemies()
	Globals.check_for_victory()


func death():
	alive = false
	Globals.record_enemy_defeat(get_name())
	$EnemySprite.visible = false
	$Particles/HitParticles.scale = Vector2(5.0, 5.0)
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _on_hit_timer_timeout():
	vulnerable = true
	hit_shader_off()
	
func hit_shader_on():
	$EnemySprite.material.set_shader_parameter("progress", 0.8)
	
func hit_shader_off():
	$EnemySprite.material.set_shader_parameter("progress", 0)
