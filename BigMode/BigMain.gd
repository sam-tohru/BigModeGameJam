extends Node2D
class_name BigMain

signal update_order_ui

@export var switch_on_wait_time: float = 0.2

@onready var player_big = $PlayerBig
@onready var orders_big = $OrdersBig


@onready var switch_timer = $timers/SwitchTimer
@onready var switch_timer_get_input = $timers/SwitchTimerGetInput
@onready var order_timer = $timers/OrderTimer
@onready var round_timer = $timers/RoundTimer



@onready var input_arr: Array = []
@onready var check_this_input: String = ''
@onready var can_check_input: bool = false

@onready var parts_markers: Array = [$Background/MaterialGoToAreas/Marker2D, $Background/MaterialGoToAreas/Marker2D2, $Background/MaterialGoToAreas/Marker2D3, $Background/MaterialGoToAreas/Marker2D4, $Background/MaterialGoToAreas/Marker2D5, $Background/MaterialGoToAreas/Marker2D6]

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.kill_big_mode.connect(switch_off)
	
	print('big main: ', globvars.small_orders_done)
	
	
	if globvars.current_round == 0:
		round_timer.wait_time = 20.0
	elif globvars.current_round <= 1:
		round_timer.wait_time = 18
	else:
		var time = (16-(globvars.current_round/2)) + (globvars.small_orders_done * 0.4)
		if time > 20.0: time = 20.0
		print('new_time: ', time)
		round_timer.wait_time = time
	
	round_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return
	if !orders_big.checking_order:
		if input_arr.size() >= orders_big.current_order.size() and orders_big.current_order.size() != 0:
			print('checking from process: ', input_arr)
			orders_big.check_order(input_arr)

func switch_on():
	pass
	
	await get_tree().create_timer(switch_on_wait_time).timeout
	

func switch_off():
	# Update points? or was that just on-going?
	self.queue_free()


func give_input(what_input: String):
	
	# Can get & hold last input while SwitchTimeGetInput running and then check
	
	if !switch_timer.is_stopped(): return
	# elif !switch_timer_get_input.is_stopped(): check_this_input = what_input
	elif can_check_input: # normal, striaght to check
		check_this_input = what_input
		check_input()

func check_input(): # Adds to array & if max it checks against current
	# if check_this_input != '': print('check input: ', check_this_input)
	
	if !orders_big.checking_order: input_arr.append(check_this_input)
	
	if input_arr.size() >= orders_big.current_order.size() and orders_big.current_order.size() != 0:
		print('Final Check: ', orders_big.check_order(input_arr), ' | Input: ', input_arr)
		input_arr = []
	
	
	check_this_input = ''

func _on_switch_timer_timeout():
	can_check_input = false
	switch_timer_get_input.start()
func _on_switch_timer_get_input_timeout(): # Runs animation if no input is pressed but was while this timer was running
	if check_this_input != '':
		if orders_big.get_next_correct() == check_this_input:
			### Maybe this could just check if input is correct, and if correct you get the points (then it can just other input, need a bool in main now)
			check_input()
			player_big.switch_girl_to(check_this_input)
			return
	
	can_check_input = true



func _on_order_timer_timeout():
	orders_big.create_order()

func _on_round_timer_timeout():
	globals.emit_signal('big_mode_done')



