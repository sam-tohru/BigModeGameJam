extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(press_main_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func press_main_menu():
	if !globvars.player_in_game_menu:
		if !get_tree().paused: globals.emit_signal('main_button_pressed')
