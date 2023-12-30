extends Node2D

var points_array = PackedVector2Array()
var index: int = 0

@onready var can_draw: bool = true
@onready var is_drawing: bool = false

@onready var timer_length = $TimerLength
@onready var timer_redundancy = $TimerRedundancy
@onready var timer_cooldown = $TimerCooldown

@onready var line_needle_to_line = $LineNeedleToLine
@onready var line = $Line2D
@onready var collision = $Area2D/CollisionPolygon2D
@onready var parent = get_parent()

@onready var sprite_needle = $Sprites

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# timer_length.timeout.connect(func(): can_draw = false; timer_redundancy.start())
	# timer_redundancy.timeout.connect(func(): if timer_length.is_stopped(): can_draw = true)


func _physics_process(delta):
	# Updates UI while timer is running
	if !timer_length.is_stopped():
		globals.emit_signal('update_ui_cap_length', (timer_length.time_left/timer_length.wait_time)*100)
	else:
		globals.emit_signal('update_ui_cap_length', 100)
	
	# if timer_redundancy.is_stopped() and !can_draw: can_draw = true
	
	if points_array is PackedVector2Array: collision.polygon = points_array
	var player_pos = parent.player_small.global_position
	
	# Needle movement
	if is_drawing:
		if player_pos[0] < sprite_needle.global_position[0]-50 and $Sprites/SpriteNeedleL.visible:
			$Sprites/SpriteNeedleL.visible = false
			$Sprites/SpriteNeedleR.visible = true
			set_up_sub_line()
		elif player_pos[0] > sprite_needle.global_position[0]+150 and $Sprites/SpriteNeedleR.visible:
			$Sprites/SpriteNeedleL.visible = true
			$Sprites/SpriteNeedleR.visible = false
			set_up_sub_line()
	
	# Input (left clicks)
	if Input.is_action_just_pressed("l_click") and timer_length.is_stopped():
		if can_draw:
			can_draw = false
			is_drawing = true
			parent.emit_signal('SFX_place', true)
			sprite_needle.global_position = Vector2(player_pos[0]-10, player_pos[1]+10) # Needle Point: -25, -30 || Hole: -10, +10
			
			timer_length.start()
			points_array.append(player_pos)
			line.add_point(player_pos)
			set_up_sub_line()
	elif Input.is_action_pressed("l_click") and is_drawing and !timer_length.is_stopped():
		if points_array.size() == 0: return # Skips if holding down and not drawing (crashes if not)
		
		if points_array[index].distance_to(player_pos) > 30 and line.get_point_position(line.get_point_count() - 1) != player_pos:
			points_array.append(player_pos)
			line.add_point(player_pos)
			index += 1
	if Input.is_action_just_released("l_click"): # and !points_array.is_empty():
		is_drawing = false
		timer_cooldown.start()
		timer_length.stop()
		stop_drawing()
		sprite_needle.global_position = Vector2.ZERO

func stop_drawing(check: bool = true):
	if points_array.is_empty(): return
	
	parent.emit_signal('SFX_place', false)
	
	if check: check_for_areas()
	
	timer_redundancy.start()
	await timer_redundancy.timeout
	
	line.clear_points()
	line_needle_to_line.clear_points()
	points_array = PackedVector2Array()
	index = 0
	
	await get_tree().create_timer(1.0).timeout
	can_draw = true

func check_for_areas():
	# print('bodies: ', $Area2D.get_overlapping_bodies())
	if $Area2D.has_overlapping_areas():
		parent.emit_signal('check_order', $Area2D.get_overlapping_areas())


func set_up_sub_line():
	if line.get_point_count() == 0: return
	
	print('set up subline')
	line_needle_to_line.clear_points()
	var r_pos = $Sprites/SpriteNeedleR/Marker2D.global_position
	var l_pos = $Sprites/SpriteNeedleL/Marker2D.global_position
	
	if $Sprites/SpriteNeedleR.visible:
		line_needle_to_line.add_point(r_pos)
	else:
		line_needle_to_line.add_point(l_pos)
	
	
	line_needle_to_line.add_point(line.get_point_position(0))
	
	

