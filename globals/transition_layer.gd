extends CanvasLayer

func change_scene(target: String, type: String) -> void:
	$AnimationPlayer.play(type)
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards(type)
