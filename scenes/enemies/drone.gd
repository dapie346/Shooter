extends CharacterBody2D

@export var speed = 100

func _process(_delta):
	var direction = Vector2(1, 0) #or: Vector2.RIGHT
	velocity = direction * speed
	move_and_slide()
