extends Node2D

@onready var small_main = $SmallMain

@onready var big_load = preload("res://BigMode/BigMain.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.restart_game.connect(reset_game_stats)
	reset_game_stats()
	globals.small_orders_done.connect(switch_mode)
	globals.big_mode_done.connect(switch_mode)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# if Input.is_action_just_pressed("p_debug"): switch_mode()

func switch_mode():
	
	if globvars.cant_change_modes: return
	
	
	if globvars.MODE == 'small': # Small to Big
		globvars.MODE = 'big'
		spawn_big_mode()
		
		# After globvar has changed
		if globvars.current_round >= 10: globals.emit_signal('game_over')
		globals.emit_signal('switch_mode_changed')
		
	elif globvars.MODE == 'big': # Big to Small ( Updates Current Round ++ )
		globvars.MODE = 'small'
		globvars.current_round += 1
		globals.emit_signal('kill_big_mode')
		# After globvar has changed
		globals.emit_signal('switch_mode_changed')

func reset_game_stats():
	print('restarting game')
	globvars.current_round = 0
	globvars.current_points = 0
	globvars.MODE = 'small'
	globals.emit_signal('kill_big_mode')
	# globals.emit_signal('switch_mode_changed')
	small_main.reset_small_main()
	


func spawn_big_mode():
	
	var big_mode = big_load.instantiate()
	# item_instance.global_position = self.global_position
	call_deferred('add_child', big_mode)
