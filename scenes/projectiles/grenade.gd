extends RigidBody2D

@export var speed: int = 1000
var target_elements = []

func explode():
	$AnimationPlayer.play("Explosion")
	for element in target_elements:
		if element.has_method("hit"):
			element.hit()
			

func _on_explosion_range_body_entered(body):
	if body in get_tree().get_nodes_in_group('Containers') + get_tree().get_nodes_in_group('Entities'):
		target_elements.append(body)


func _on_explosion_range_body_exited(body):
	if body in get_tree().get_nodes_in_group('Containers') + get_tree().get_nodes_in_group('Entities'):
		var index = target_elements.find(body)
		if index != -1:
			target_elements.remove_at(index)
