extends Node2D

@onready var material_item = preload("res://SmallMode/Items/ItemSmall.tscn")

@export var max_items: int = 8
@onready var spawned_array: Array = []

@onready var spawn_timer = $SpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_item()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func clean_array():
	var i = 0
	for spawned in spawned_array:
		if !is_instance_valid(spawned): spawned_array.remove_at(i)
		i += 1


func spawn_item(what_to_spawn: String = ''):
	if spawned_array.size() >= max_items: return
	elif globvars.MODE != 'small': return
	
	var gotta_spawn_a = determine_spawn()
	if gotta_spawn_a != '': pass
	
	var item_instance = material_item.instantiate()
	# item_instance.global_position = self.global_position
	call_deferred('add_child', item_instance)
	spawned_array.append(item_instance)
	
	if gotta_spawn_a != '':
		print('setting up a: ', gotta_spawn_a)
		item_instance.item_type = gotta_spawn_a
		item_instance.set_up_item()
	
	# spawn_timer.start()

func determine_spawn() -> String: # Only returns if an item has 0 spawned (none)
	clean_array()
	var item_dict: Dictionary = {}
	for itm in spawned_array:
		if !is_instance_valid(itm): continue
		var type = itm.item_type
		if item_dict.has(type): item_dict[type] += 1
		else: 
			var dict_entry = {type: 1}
			item_dict.merge(dict_entry)
	
	var lowest = 100
	for key in globvars.item_dictionary:
		if item_dict.has(key) == false: return key
	
	return ''

func remove_item():
	
	clean_array()
	var to_remove = determine_what_to_remove()
	
	for item in spawned_array:
		
		if item.item_type == to_remove:
			item.kill_self()
			clean_array()
			return

func determine_what_to_remove():
	var item_dictionary: Dictionary = {}
	clean_array()
	
	for itemKey in globvars.item_dictionary.keys():
		item_dictionary[itemKey] = 0
	
	for item in spawned_array:
		if !is_instance_valid(item): continue
		elif item.item_type == '': continue
		
		item_dictionary[item.item_type] += 1
	
	# Calculate the totam amount of items spawned
	var high_spawned_item = 'fabric'
	var i = item_dictionary[high_spawned_item]
	for item in item_dictionary:
		if item_dictionary[item] >= i:
			i = item_dictionary[item]
			high_spawned_item = item
	
	return high_spawned_item
	
	


func _on_spawn_timer_timeout():
	clean_array()
	
	if spawned_array.size() < max_items: 
		spawn_item()
	else: 
		pass
		# printerr('Spawner has reached max size, not set-up')
