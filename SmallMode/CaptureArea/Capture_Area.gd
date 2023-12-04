extends Node2D

var points_array = PackedVector2Array()
var index: int = 0

@onready var can_draw: bool = true

@onready var timer_length = $TimerLength
@onready var timer_redundancy = $TimerRedundancy

@onready var line = $Line2D
@onready var collision = $Area2D/CollisionPolygon2D
@onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_length.timeout.connect(func(): can_draw = false; timer_redundancy.start())
	# timer_redundancy.timeout.connect(func(): if timer_length.is_stopped(): can_draw = true)


func _physics_process(delta):
	if points_array is PackedVector2Array and can_draw: collision.polygon = points_array
	var player_pos = parent.player_small.global_position
	
	if Input.is_action_just_pressed("l_click"):
		if timer_redundancy.is_stopped() and !can_draw: can_draw = true
		elif can_draw:
			timer_length.start()
			points_array.append(player_pos)
			line.add_point(player_pos)
	elif Input.is_action_pressed("l_click") and can_draw:
		if points_array.size() == 0: return # Skips if holding down and not drawing (crashes if not)
		
		if points_array[index].distance_to(player_pos) > 30 and line.get_point_position(line.get_point_count() - 1) != player_pos:
			points_array.append(player_pos)
			line.add_point(player_pos)
			index += 1
	if Input.is_action_just_released("l_click") and !points_array.is_empty():
		stop_drawing()

func stop_drawing(check: bool = true):
	if check: check_for_areas()
	
	timer_redundancy.start()
	await timer_redundancy.timeout
	
	line.clear_points()
	points_array = PackedVector2Array()
	index = 0
	can_draw = true

func check_for_areas():
	# print('bodies: ', $Area2D.get_overlapping_bodies())
	if $Area2D.has_overlapping_areas():
		parent.emit_signal('check_order', $Area2D.get_overlapping_areas())



