extends PanelContainer

@onready var value_left = $OrderCC/HBoxContainer/VBox/HBoxContainer/TextureRect/thread_left/ValueLeft

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.update_ui_cap_length.connect(update_ui_cap_length)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_ui_cap_length(percentage):
	value_left.text = str(snapped(percentage, 0.1))
