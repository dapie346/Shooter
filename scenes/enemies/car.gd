extends Enemy

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D
@export var damage: int = 60
var target: CharacterBody2D

func _ready():
	health = 150


func _process(_delta):
	if player_nearby:
		$Turret.look_at(Globals.player_pos)


func _on_notice_area_body_entered(body):
	if body.is_in_group('Player') and alive:
		target = body
		player_nearby = true
		$AnimationPlayer.play("laser_load")

func _on_notice_area_body_exited(body):
	if body.is_in_group('Player'):
		target = null
		player_nearby = false
		$AnimationPlayer.pause()
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(line1, "width", 0, randf_range(0.1, 0.5))
		tween.tween_property(line2, "width", 0, randf_range(0.1, 0.5))
		await tween.finished
		$AnimationPlayer.stop()

func hit_shader_on():
	$EnemySprite.material.set_shader_parameter("progress", 0.8)
	$Turret/Sprite2D.material.set_shader_parameter("progress", 0.8)
	
func hit_shader_off():
	$EnemySprite.material.set_shader_parameter("progress", 0)
	$Turret/Sprite2D.material.set_shader_parameter("progress", 0)
	
func fire():
	if target and alive:
		if target.has_method("hit"):
			target.hit(damage)

func check_conditions():
	var level = get_parent().get_parent().get_parent().get_parent()
	if level != null:
		level.check_for_enemies()
	Globals.check_for_victory()

func death():
	alive = false
	Globals.record_enemy_defeat(get_parent().get_parent().get_name())
	target = null
	$Explosion.play()
	$EnemySprite.visible = false
	$Turret.visible = false
	$Particles/HitParticles.scale = Vector2(5.0, 5.0)
	await get_tree().create_timer(0.5).timeout
	get_parent().get_parent().queue_free()
