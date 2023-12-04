extends Area2D

@export_enum('fabric', 'button') var item_type: String


@export_enum('white', 'red', 'blue') var current_color: String


# Replace with sprite when have
@onready var sprite_item = $ColorRect
# Sprites


# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_item()
	move_idle()

func set_up_item(random_item: bool = true):
	
	if item_type == '':
		var new_item: String = globvars.item_dictionary.keys()[randi() % globvars.item_dictionary.size()]
		item_type = new_item
	
	# Color only for fabric & button
	if current_color == '': # Normal set-up (random or weighted idk yet)
		# Gets random new color (from colors_dictionary, set's curren_color enum to it also
		var new_col: String = globvars.colors_dictionary.keys()[randi() % globvars.colors_dictionary.size()]
		current_color = new_col
	else: # Debug manual set item
		pass
	
	set_up_sprites()
	
	# Sets Color Modulate
	sprite_item.modulate = globvars.colors_dictionary[current_color]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print('Material tring to find areas: ', self.get_overlapping_areas())

func set_up_sprites():
	print(item_type)
	$MainSprite2D.animation = item_type

func move_idle():
	var rand_stay = randf_range(0.1, 0.3)
	var rand_arr = [randf_range(-50, 50), randf_range(-50, 50)]
	
	var tween = create_tween()
	tween.tween_property(self, 'global_position', Vector2(self.global_position[0]+rand_arr[0], self.global_position[1]+rand_arr[1]), 1.0-rand_stay)
	tween.tween_interval(rand_stay)
	tween.tween_callback(move_idle)
