extends Node


func play():
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.volume_db = -15

func stop():
	var tween = create_tween()
	tween.tween_property($AudioStreamPlayer, "volume_db", -80, 2)
