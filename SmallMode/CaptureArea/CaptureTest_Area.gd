extends Node2D

var points_array = PackedVector2Array()
var index: int = 0

@onready var can_draw: bool = true

@onready var timer_length = $TimerLength

@onready var area = $Area2D
@onready var collision = $Area2D/CollisionShape2D
@onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_length.timeout.connect(func(): can_draw = false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# check_for_areas()
	# collision.polygon = points_array
	var player_pos = parent.player_small.global_position
	
	if Input.is_action_just_pressed("l_click") and can_draw:
		start_drawing(player_pos)
	elif Input.is_action_pressed("l_click") and can_draw:
		add_to_drawing(player_pos)
	if Input.is_action_just_released("l_click"):
		stop_drawing()

func start_drawing(player_pos: Vector2):
	timer_length.start()
	points_array.append(player_pos)

func add_to_drawing(player_pos: Vector2):
	if points_array.size() == 0: return # Skips if holding down and not drawing (crashes if not)
	
	if points_array[index].distance_to(player_pos) > 30:
		points_array.append(player_pos)
		index += 1

func stop_drawing():
	## If not working might just check if items are in area (might be too much processing)
	# Spawns new collisionShape with the points_array
	var col_shape = CollisionPolygon2D.new()
	col_shape.set_polygon(points_array)
	var ownerId = area.create_shape_owner(area)
	area.shape_owner_add_shape(ownerId, col_shape)
	# area.add_child(col_shape)
	print(area.get_shape_owners())
	
	check_for_areas()
	await get_tree().create_timer(1.0).timeout
	
	points_array = PackedVector2Array()
	index = 0
	col_shape.queue_free()
	
	can_draw = true

func check_for_areas():
	print(area.get_overlapping_areas())

