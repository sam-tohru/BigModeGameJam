extends Node2D

var points_array = PackedVector2Array()
var index: int = 0

@onready var can_draw: bool = true

@onready var timer_length = $TimerLength

@onready var collision = $Area2D/CollisionPolygon2D
@onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_length.timeout.connect(func(): can_draw = false)


func _physics_process(delta):
	if points_array is PackedVector2Array: collision.polygon = points_array
	var player_pos = parent.player_small.global_position
	
	if Input.is_action_just_pressed("l_click") and can_draw:
		timer_length.start()
		points_array.append(player_pos)
	elif Input.is_action_pressed("l_click") and can_draw:
		if points_array.size() == 0: return # Skips if holding down and not drawing (crashes if not)
		
		if points_array[index].distance_to(player_pos) > 30:
			points_array.append(player_pos)
			index += 1
	if Input.is_action_just_released("l_click"):
		stop_drawing()

func stop_drawing():
	check_for_areas()
	await get_tree().create_timer(0.4).timeout
	points_array = PackedVector2Array()
	index = 0
	can_draw = true

func check_for_areas():
	print($Area2D.get_overlapping_areas())
	# print('bodies: ', $Area2D.get_overlapping_bodies())

