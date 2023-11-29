extends Enemy

var speed: int = 200
var target: CharacterBody2D
var damage = 40
@onready var body_part_sprites = [
	$EnemySprite/Torso/Torso, $EnemySprite/Torso/FrontRightLeg/Sprite2D, 
	$EnemySprite/Torso/FrontRightLeg/FrontRightClaw/Sprite2D, $EnemySprite/Torso/FrontLeftLeg/Sprite2D, 
	$EnemySprite/Torso/FrontLeftLeg/FrontLeftClaw/Sprite2D, $EnemySprite/Torso/Head/Sprite2D, 
	$EnemySprite/Torso/Head/RightClaw/Sprite2D, $EnemySprite/Torso/Head/LeftClaw/Sprite2D, 
	$EnemySprite/Torso/BackRightLeg/Sprite2D, $EnemySprite/Torso/BackRightLeg/BackRightClaw/Sprite2D, 
	$EnemySprite/Torso/BackLeftLeg/Sprite2D, $EnemySprite/Torso/BackLeftLeg/BackLeftClaw/Sprite2D
]

func _ready():
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_pos
	health = 100

func _physics_process(_delta):
	if player_nearby and alive:
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		var look_angle = direction.angle()
		rotation = look_angle + PI /2


func _on_notice_area_body_entered(body):
	if body.is_in_group('Player') and alive:
		player_nearby = true
		$AnimationPlayer.play("walk")


func _on_notice_area_body_exited(body):
	if body.is_in_group('Player'):
		player_nearby = false
		$AnimationPlayer.stop()


func _on_navigation_timer_timeout():
	if player_nearby:
		$NavigationAgent2D.target_position = Globals.player_pos
		
func attack():
	if target.has_method("hit") and alive:
		target.hit(damage)
		

func _on_attack_area_body_entered(body):
	if body.is_in_group('Player') and alive:
		target = body
		$AnimationPlayer.play("attack")


func _on_attack_area_body_exited(body):
	if body.is_in_group('Player') and alive:
		target = null
		$AnimationPlayer.stop()
		$AnimationPlayer.play("walk")

func hit_shader_on():
	for body_part in body_part_sprites:
		body_part.material.set_shader_parameter("progress", 0.8)
	
func hit_shader_off():
	for body_part in body_part_sprites:
		body_part.material.set_shader_parameter("progress",0)
