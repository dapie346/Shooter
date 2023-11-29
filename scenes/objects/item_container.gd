extends StaticBody2D
class_name ContainerParent

signal open()

@export var items_spawned: int
@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
var closed: bool = true

func hit(_damage: int):
	if closed:
		closed = false
		$HitSound.play()
		open_lid()
		for i in range(items_spawned):
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			open.emit(pos, current_direction)

func open_lid():
	$LidSprite.hide()
	collision_layer &= ~(1 << 6)
	collision_mask &= ~(1 << 3)
