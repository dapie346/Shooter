extends CharacterBody2D
class_name Enemy

@export var health: int
var player_nearby: bool = false
var vulnerable: bool = true


func hit(damage: int) -> void:
	if vulnerable:
		vulnerable = false
		$Timers/HitTimer.start()
		$EnemySprite.material.set_shader_parameter("progress", 0.8)
		health -= damage
		if health <= 0:
			queue_free()


func _on_hit_timer_timeout():
	vulnerable = true
	$EnemySprite.material.set_shader_parameter("progress", 0)
