extends Area2D

@export var rotation_speed: int = 3
var possible_types = ['laser', 'grenade', 'health']
var type = possible_types[randi()%len(possible_types)]

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color('81d0f6')
	if type == 'grenade':
		$Sprite2D.modulate = Color('ff4f45')
	if type == 'health':
		$Sprite2D.modulate = Color('00914c')
func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	body.add_item(type)
	queue_free()
