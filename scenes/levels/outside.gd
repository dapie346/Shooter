extends LevelParent

func _on_gate_player_entered_gate(_body):
	if _body == $Player:
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property($Player, "modulate:a", 0, 1)
		tween.tween_property($Player/Camera2D, "zoom", Vector2(0.8, 0.8), 1)
		tween.tween_property($Player, "max_speed", 0, 0.5)
		

func _on_house_player_entered():
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.8, 0.8), 1)


func _on_house_player_exited():
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
