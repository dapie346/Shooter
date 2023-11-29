extends LevelParent

func _on_area_2d_body_entered(_body):
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player, "modulate:a", 0, 1)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
	tween.tween_property($Player, "max_speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn", "fade_to_black")

func check_for_enemies():
	if $Enemies.get_child_count() <= 1:
		Globals.inside_cleared = true
