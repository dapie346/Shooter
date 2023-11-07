extends LevelParent

#@export var inside_level_scene: PackedScene

func _on_house_player_entered():
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.8, 0.8), 1)


func _on_house_player_exited():
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)


func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player, "modulate:a", 0, 1)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.8, 0.8), 1)
	tween.tween_property($Player, "max_speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")
