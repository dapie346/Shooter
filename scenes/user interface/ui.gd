extends CanvasLayer

var green: Color = Color("00a64c")
var red: Color = Color("c6193c")

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect

func _ready():
	update_laser_text()
	update_grenade_text()

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	if Globals.laser_amount > 0:
		laser_label.modulate = green
		laser_icon.modulate = green
	else:
		laser_label.modulate = red
		laser_icon.modulate = red
		
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	if Globals.grenade_amount > 0:
		grenade_label.modulate = green
		grenade_icon.modulate = green
	else:
		grenade_label.modulate = red
		grenade_icon.modulate = red
