extends StaticBody2D
class_name ContainerParent

signal open()

var opened: bool = false
@export var items_spawned: int = 5
@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)

func hit():
	if !opened:
		$LidSprite.hide()
		collision_layer &= ~(1 << 6)
		collision_mask &= ~(1 << 3)
		for i in range(items_spawned):
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			open.emit(pos, current_direction)
		opened = true
