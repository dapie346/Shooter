extends LevelParent


func _ready():
	super._ready()
	if Globals.outside_left:
		$Player.position = $PlayerReturnPoint.position

func _on_house_player_entered():
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.8, 0.8), 1)


func _on_house_player_exited():
	var tween = create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)


func _on_gate_player_entered_gate(_body):
	Globals.outside_left = true
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player, "modulate:a", 0, 1)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.8, 0.8), 1)
	tween.tween_property($Player, "max_speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn", "fade_to_black")

func check_for_enemies():
	if $Enemies.get_child_count() <= 1:
		Globals.outside_cleared = true
