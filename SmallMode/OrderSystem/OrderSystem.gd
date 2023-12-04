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

func check_order(order_to_check: Array):
	var check = []
	for item in order_to_check:
		check.append(item.item_type)
	
	print('check: ', check.hash(), ' | against: ', current_order.hash())
	if check.hash() == current_order.hash():
		generate_random_order()
		print('correct order')
		return true
	else:
		return false

func generate_random_order():
	
	var subO1 = globvars.item_dictionary.keys()[randi() % globvars.item_dictionary.size()]
	var subO2 = globvars.item_dictionary.keys()[randi() % globvars.item_dictionary.size()]
	
	current_order = [subO1, subO2]
	parent.emit_signal('updated_order', current_order)
	
