extends Area2D

@export_enum('white', 'red', 'blue') var current_color: String
static var colors_dictionary = {
	'white': Color('e3cfb4'),
	'red': Color('b03a48'),
	'blue': Color('243d5c'),
}

# Replace with sprite when have
@onready var sprite_item = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_item()

func set_up_item(random_item: bool = true):
	if current_color == '': # Normal set-up (random or weighted idk yet)
		# Gets random new color (from colors_dictionary, set's curren_color enum to it also
		var new_col: String = colors_dictionary.keys()[randi() % colors_dictionary.size()]
		current_color = new_col
	else: # Debug manual set item
		pass
		
	
	# Sets Color Modulate
	sprite_item.modulate = colors_dictionary[current_color]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print('Material tring to find areas: ', self.get_overlapping_areas())

