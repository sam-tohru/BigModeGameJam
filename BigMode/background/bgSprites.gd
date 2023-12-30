extends Node2D

@onready var bg_2_21_neutral = $"Bg2-21Neutral"
@onready var bg_2_22_sad = $"Bg2-22Sad"
@onready var bg_2_23_happy = $"Bg2-23Happy"

@onready var bg_2_51_sad = $"Bg2-51Sad"
@onready var bg_2_52_neutral = $"Bg2-52Neutral"
@onready var bg_2_53_happy = $"Bg2-53Happy"


# Called when the node enters the scene tree for the first time.
func _ready():
	globals.added_points.connect(added_points_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func added_points_change(how_much, _pos):
	
	var orig_pos_bot = bg_2_52_neutral.global_position
	var orig_pos_top = bg_2_21_neutral.global_position
	
	if how_much >= 10: # Happy
		
		var tween = create_tween()
		tween.tween_property(bg_2_21_neutral, 'global_position', Vector2(orig_pos_top[0], orig_pos_top[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_22_sad, 'global_position', Vector2(orig_pos_top[0], orig_pos_top[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_23_happy, 'global_position', Vector2(orig_pos_top[0], orig_pos_top[1]+50), 0.05)
		
		tween.tween_property(bg_2_21_neutral, 'visible', false, 0.01)
		tween.parallel().tween_property(bg_2_22_sad, 'visible', false, 0.01)
		tween.parallel().tween_property(bg_2_23_happy, 'visible', true, 0.01)
		
		tween.tween_callback(globals.emit_signal.bind('shake_the_camera', 'walk_shake'))
		
		tween.tween_property(bg_2_21_neutral, 'global_position', orig_pos_top, 0.05)
		tween.parallel().tween_property(bg_2_22_sad, 'global_position', orig_pos_top, 0.05)
		tween.parallel().tween_property(bg_2_23_happy, 'global_position', orig_pos_top, 0.05)
		
		tween.tween_property(bg_2_52_neutral, 'global_position', Vector2(orig_pos_bot[0], orig_pos_bot[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_51_sad, 'global_position', Vector2(orig_pos_bot[0], orig_pos_bot[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_53_happy, 'global_position', Vector2(orig_pos_bot[0], orig_pos_bot[1]+50), 0.05)
		
		tween.tween_property(bg_2_52_neutral, 'visible', false, 0.01)
		tween.parallel().tween_property(bg_2_51_sad, 'visible', false, 0.01)
		tween.parallel().tween_property(bg_2_53_happy, 'visible', true, 0.01)
		
		tween.tween_property(bg_2_52_neutral, 'global_position', orig_pos_bot, 0.05)
		tween.parallel().tween_property(bg_2_51_sad, 'global_position', orig_pos_bot, 0.05)
		tween.parallel().tween_property(bg_2_53_happy, 'global_position', orig_pos_bot, 0.05)
	
	
	
	elif how_much >= 0: # Neutral
		var tween = create_tween()
		tween.tween_property(bg_2_21_neutral, 'global_position', Vector2(orig_pos_top[0], orig_pos_top[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_22_sad, 'global_position', Vector2(orig_pos_top[0], orig_pos_top[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_23_happy, 'global_position', Vector2(orig_pos_top[0], orig_pos_top[1]+50), 0.05)
		
		tween.tween_property(bg_2_21_neutral, 'visible', true, 0.01)
		tween.parallel().tween_property(bg_2_22_sad, 'visible', false, 0.01)
		tween.parallel().tween_property(bg_2_23_happy, 'visible', false, 0.01)
		
		tween.tween_callback(globals.emit_signal.bind('shake_the_camera', 'walk_shake'))
		
		tween.tween_property(bg_2_21_neutral, 'global_position', orig_pos_top, 0.05)
		tween.parallel().tween_property(bg_2_22_sad, 'global_position', orig_pos_top, 0.05)
		tween.parallel().tween_property(bg_2_23_happy, 'global_position', orig_pos_top, 0.05)
		
		tween.tween_property(bg_2_52_neutral, 'global_position', Vector2(orig_pos_bot[0], orig_pos_bot[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_51_sad, 'global_position', Vector2(orig_pos_bot[0], orig_pos_bot[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_53_happy, 'global_position', Vector2(orig_pos_bot[0], orig_pos_bot[1]+50), 0.05)
		
		tween.tween_property(bg_2_52_neutral, 'visible', true, 0.01)
		tween.parallel().tween_property(bg_2_51_sad, 'visible', false, 0.01)
		tween.parallel().tween_property(bg_2_53_happy, 'visible', false, 0.01)
		
		tween.tween_property(bg_2_52_neutral, 'global_position', orig_pos_bot, 0.05)
		tween.parallel().tween_property(bg_2_51_sad, 'global_position', orig_pos_bot, 0.05)
		tween.parallel().tween_property(bg_2_53_happy, 'global_position', orig_pos_bot, 0.05)
	else: # Below
		var tween = create_tween()
		tween.tween_property(bg_2_21_neutral, 'global_position', Vector2(orig_pos_top[0], orig_pos_top[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_22_sad, 'global_position', Vector2(orig_pos_top[0], orig_pos_top[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_23_happy, 'global_position', Vector2(orig_pos_top[0], orig_pos_top[1]+50), 0.05)
		
		tween.tween_property(bg_2_21_neutral, 'visible', false, 0.01)
		tween.parallel().tween_property(bg_2_22_sad, 'visible', true, 0.01)
		tween.parallel().tween_property(bg_2_23_happy, 'visible', false, 0.01)
		
		tween.tween_callback(globals.emit_signal.bind('shake_the_camera', 'walk_shake'))
		
		tween.tween_property(bg_2_21_neutral, 'global_position', orig_pos_top, 0.05)
		tween.parallel().tween_property(bg_2_22_sad, 'global_position', orig_pos_top, 0.05)
		tween.parallel().tween_property(bg_2_23_happy, 'global_position', orig_pos_top, 0.05)
		
		tween.tween_property(bg_2_52_neutral, 'global_position', Vector2(orig_pos_bot[0], orig_pos_bot[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_51_sad, 'global_position', Vector2(orig_pos_bot[0], orig_pos_bot[1]+50), 0.05)
		tween.parallel().tween_property(bg_2_53_happy, 'global_position', Vector2(orig_pos_bot[0], orig_pos_bot[1]+50), 0.05)
		
		tween.tween_property(bg_2_52_neutral, 'visible', false, 0.01)
		tween.parallel().tween_property(bg_2_51_sad, 'visible', true, 0.01)
		tween.parallel().tween_property(bg_2_53_happy, 'visible', false, 0.01)
		
		tween.tween_property(bg_2_52_neutral, 'global_position', orig_pos_bot, 0.05)
		tween.parallel().tween_property(bg_2_51_sad, 'global_position', orig_pos_bot, 0.05)
		tween.parallel().tween_property(bg_2_53_happy, 'global_position', orig_pos_bot, 0.05)
	

