extends Enemy

var in_range: bool = false
var speed = 350
var damage = 10
var target: CharacterBody2D


func _ready():
	health = 20


func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if not in_range:
			var direction = (Globals.player_pos - global_position).normalized()
			velocity = direction * speed
			move_and_slide()


func _on_attack_area_body_entered(body):
	if body.is_in_group('Player'):
		target = body
		in_range = true
		$EnemySprite.play("attack")


func _on_attack_area_body_exited(body):
	if body.is_in_group('Player'):
		in_range = false


func _on_enemy_sprite_animation_finished():
	if in_range and target.has_method("hit"):
		target.hit(damage)
		$Timers/AttackTimer.start()


func _on_notice_area_body_entered(body):
	if body.is_in_group('Player'):
		player_nearby = true
		$EnemySprite.play("walk")


func _on_notice_area_body_exited(body):
	if body.is_in_group('Player'):
		player_nearby = false


func _on_attack_timer_timeout():
	$EnemySprite.play("attack")
