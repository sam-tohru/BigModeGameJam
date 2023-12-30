extends Node

@onready var max = 0
@onready var to_check = []
@onready var current_order = ['left', 'up']
# @onready var penalty_order = ''

@onready var parent = get_parent() as BigMain

@onready var checking_order: bool = false


func _ready():
	create_order()


func give_points(how_much): # Emits global signal 'added_points'
	globvars.current_points += how_much
	globals.emit_signal('added_points', how_much, parent.parts_markers.pick_random().global_position)

func create_order():
	var possible_poses = ['left', 'up', 'down', 'right']
	
	current_order = []
	current_order = [possible_poses.pick_random(), possible_poses.pick_random()]
	
	parent.emit_signal('update_order_ui', current_order)


func get_next_correct():
	
	if current_order.is_empty(): return ''
	if current_order[to_check.size()] == null: return ''
	
	return current_order[to_check.size()]

func add_to_check(add_to: String):
	if to_check.size() < current_order.size():
		to_check.append(add_to)
	
	if to_check.size() >= current_order.size():
		pass
		# Check order

func check_order(input_arr: Array) -> bool:
	checking_order = true
	var copy_order = current_order.duplicate()
	var points_gained = 0
	print(copy_order,' against checking input arr: ',input_arr)
	for check in input_arr:
		if copy_order.has(check): 
			points_gained += 5
			copy_order.erase(check) # One input is correct (needs to erase after, probs give some points before)
#		else: # Not in current_order (copy) and returns false
#			give_points(points_gained)
#			checking_order = false
#			return false
	
	# Order completed
	if copy_order.is_empty():
		points_gained += 5
	give_points(points_gained)
	# create_order() ## MIGHT NEED TO MOVE THIS, RUNS WHEN ORDER IS COMPLETED
	checking_order = false
	return true
