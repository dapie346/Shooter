extends Node2D

var green: Color = Color("00a64c")
var red: Color = Color("c6193c")

@onready var header: Label = $CanvasLayer/Menu/Header

func _ready():
	if Globals.game_completed:
		header.text = "You Won!\nYou are Human Bean and a Real Hero!"
		header.modulate = green
	if Globals.game_over:
		header.text = "Game Over"
		header.modulate = red


func _on_new_game_pressed():
	Globals.set_default_values()
	await TransitionLayer.change_scene("res://scenes/levels/outside.tscn", "fade_to_black")
	Music.play()


func _on_exit_pressed():
	get_tree().quit()
