extends Node


func play():
	$BattleMusic.play()
	$BattleMusic.volume_db = -15

func stop():
	var tween = create_tween()
	tween.tween_property($BattleMusic, "volume_db", -80, 2)
	
func game_over():
	$GameOver.play()
	
func player_won():
	$Success.play()

func success_stop():
	if $Success.playing:
		var tween = create_tween()
		tween.tween_property($Success, "volume_db", -80, 4)
		$Success.stop()
