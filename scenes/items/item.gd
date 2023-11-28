extends Area2D

@export var rotation_speed: int = 3
@export var min_distance: int = 200
@export var max_distance: int = 300
var direction: Vector2
var distance: int = randi_range(min_distance, max_distance)

var possible_types = {
	'laser': 4,  # Higher weight means more common
	'grenade': 1,
	'health': 3
}

var type = weighted_random_choice(possible_types)
var target_body: CharacterBody2D
var is_moving = false
var speed = 1000

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color('81d0f6')
	if type == 'grenade':
		$Sprite2D.modulate = Color('ff4f45')
	if type == 'health':
		$Sprite2D.modulate = Color('00914c')
	#tween
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.6).from(Vector2(0,0))
	tween.tween_property(self, "position", target_pos, 0.5)
	

func _process(delta):
	rotation += rotation_speed * delta
	if is_moving:
		move_towards_target(delta)

func _on_detection_area_body_entered(body):
	target_body = body as CharacterBody2D
	is_moving = true


func _on_body_entered(_body):
	if type == 'laser':
		Globals.laser_amount += 10
	if type == 'grenade':
		Globals.grenade_amount += 2
	if type == 'health':
		Globals.health += 40
	$Sprite2D.visible = false
	$ItemPickedSound.play()
	await get_tree().create_timer(0.5).timeout
	queue_free()

	
func move_towards_target(delta):
	if target_body:
		direction = (target_body.global_position - global_position).normalized()
		global_position += direction * speed * delta


func weighted_random_choice(items: Dictionary) -> String:
	var total_weight = 0
	var weights = []
	var keys = []

	# Split the dictionary into weights and keys for easier processing
	for key in items:
		weights.append(items[key])
		keys.append(key)
		total_weight += items[key]

	# Generate a random index based on the total weight
	var rand_weight = randi() % total_weight
	var weight_sum = 0

	# Determine which item this index corresponds to
	for i in range(weights.size()):
		weight_sum += weights[i]
		if rand_weight < weight_sum:
			return keys[i]

	# Fallback
	return keys[keys.size() - 1]
