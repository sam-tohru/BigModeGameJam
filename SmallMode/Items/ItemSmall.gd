extends Area2D

@export_enum('fabric', 'button') var item_type: String


@export_enum('white', 'red', 'blue') var current_color: String

@export_range(3,9) var max_idle_ticks: int = 4
var curr_idle_tick = 0

# Replace with sprite when have
@onready var sprite_item = $ColorRect
# Sprites

@onready var parent: SmallBoard = get_parent().get_parent()
@onready var dying_animation: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.restart_game.connect(self.queue_free)
	set_up_item()
	move_idle()

func set_up_item(random_item: bool = true):
	
	if item_type == '':
		var new_item: String = globvars.item_dictionary.keys()[randi() % globvars.item_dictionary.size()]
		item_type = new_item
	
	
	set_up_sprites()


func kill_self():
	if dying_animation: return
	dying_animation = true
	var tween = create_tween()
	tween.tween_property(self, 'rotation_degrees', 720, 0.1)
	tween.parallel().tween_property(self, 'modulate', Color.TRANSPARENT, 0.1)
	tween.tween_callback(self.queue_free)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#print('Material tring to find areas: ', self.get_overlapping_areas())

func set_up_sprites():
	$MainSprite2D.animation = item_type

func move_idle():
	if curr_idle_tick >= max_idle_ticks:
		move_point()
		curr_idle_tick = 0
		return
	else: curr_idle_tick += 1
	var rand_stay = randf_range(0.1, 0.3)
	var rand_arr = [randf_range(-50, 50), randf_range(-50, 50)]
	
	var tween = create_tween()
	tween.tween_property(self, 'global_position', Vector2(self.global_position[0]+rand_arr[0], self.global_position[1]+rand_arr[1]), 1.0-rand_stay)
	tween.tween_interval(rand_stay)
	tween.tween_callback(move_idle)

func move_point():
	
	var rand_point = parent.MatGoToAreas.pick_random().global_position
	var time_to = 4.0
	
	var tween = create_tween()
	tween.tween_property(self, 'global_position', rand_point, time_to)
	tween.tween_callback(move_idle)
