extends Node

signal stat_change

var laser_amount: int = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		stat_change.emit()
var grenade_amount: int = 5:
	get:
		return grenade_amount
	set(value):
		grenade_amount = value
		stat_change.emit()
var health: int = 60:
	get:
		return health
	set(value):
		health = value
		stat_change.emit()
