extends Label

@onready var parent = self.owner as SmallBoard

# Called when the node enters the scene tree for the first time.
func _ready():
	parent.updated_order.connect(updated_order)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func updated_order(new_order: Array):
	print(new_order)
	if new_order.size() > 2: printerr('label updated order only does 2 arrays, change this')
	
	self.text = str('Order: ', new_order[0], ' & ', new_order[1])
	
