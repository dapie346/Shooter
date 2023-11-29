extends Enemy

var exploding: bool = false
var speed: int = 100
var max_speed: int = 600
var damage = 60
var explosion_radius = 300


func _ready():
	health = 40
	$Explosion.hide()
	$EnemySprite.show()


func _process(delta):
	if player_nearby and not exploding and alive:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - global_position).normalized()
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			death()


func death():
	alive = false
	Globals.record_enemy_defeat(get_name())
	exploding = true
	$AnimationPlayer.play("Explosion")
	var targets = get_tree().get_nodes_in_group('Containers') + get_tree().get_nodes_in_group('Entities')
	for target in targets:
		var in_range = target.global_position.distance_to(global_position) < explosion_radius
		if target.has_method("hit") and in_range:
			target.hit(damage)


func _on_notice_area_body_entered(body):
	if body.is_in_group('Player') and alive:
		player_nearby = true
		var tween = create_tween()
		tween.tween_property(self, "speed", max_speed, 6)
