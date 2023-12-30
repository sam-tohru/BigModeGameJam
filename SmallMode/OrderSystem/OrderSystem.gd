extends Node2D

var current_order: Array = []
@onready var parent = get_parent() as SmallBoard



# Called when the node enters the scene tree for the first time.
func _ready():
	parent.check_order.connect(check_order)
	generate_random_order()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func order_skipped():
	
	# Loses X points
	give_points(-5)
	
	generate_random_order()

func give_points(how_much): # Emits global signal 'added_points'
	globvars.current_points += how_much
	globals.emit_signal('added_points', how_much, parent.player_small.global_position)

func check_order(order_to_check: Array):
	if globvars.MODE != 'small': return
	
	var check = []
	for item in order_to_check:
		check.append(item.item_type)
		item.queue_free()
	
	
	if check_if_arrays_same(check, current_order):
		give_points(current_order.size()*5)
		if parent.orders_done >= parent.orders_to_do: globals.emit_signal('small_orders_done') ; parent.orders_done = 0
		else: parent.orders_done += 1
		generate_random_order()
		return true
	else:
		var points_to_give = -5
		# Checks if contains some (for some points)
		var done = []
		for i in check:
			if current_order.has(i) and !done.has(i): points_to_give += 5 ; done.append(i)
		
		give_points(points_to_give)
		parent.emit_signal('small_incorrect_order')
		return false

func check_if_arrays_same(arr_1: Array, arr_2: Array) -> bool:
	
	if arr_1.size() != arr_2.size(): return false
	for item in arr_1:
		if !arr_2.has(item):
			return false
		if arr_1.count(item) != arr_2.count(item):
			return false
	
	return true

func generate_random_order():
	
	if globvars.current_round == 0: pass
	elif globvars.current_round == 1: pass
	
	var subO1 = globvars.item_dictionary.keys()[randi() % globvars.item_dictionary.size()]
	var subO2 = globvars.item_dictionary.keys()[randi() % globvars.item_dictionary.size()]
	var subO3 = globvars.item_dictionary.keys()[randi() % globvars.item_dictionary.size()]
	
	
	if globvars.current_round <= 1: current_order = [subO1]
	elif globvars.current_round <= 6: # Random chance, more common to get 2
		if randi_range(1,12) <= globvars.current_round: current_order = [subO1, subO2]
		else: current_order = [subO1]
	else: # Final range (includes 3) from round 7
		if randi_range(1,12) <= 3: current_order = [subO1, subO2, subO3]
		elif randi_range(1,12) <= 9: current_order = [subO1, subO2]
		else: current_order = [subO1]
	
	globvars.current_order = current_order
	parent.emit_signal('updated_order', current_order)
	
	

