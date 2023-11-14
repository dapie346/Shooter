extends Area2D

@export var damage: int = 10
@export var speed: int = 2000
var direction: Vector2 = Vector2.UP

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(_body):
	if _body.has_method("hit"):
		_body.hit(damage)
	queue_free()


func _on_self_destruct_timer_timeout():
	queue_free()
