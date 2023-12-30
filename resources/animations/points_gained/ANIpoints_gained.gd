extends Node2D

@onready var firework_1 = $firework_1
@onready var firework_2 = $firework_2

@onready var label = $Label

@export var score: int = 25

static var points_5 = '[shake rate=20.0 level=5 connected = 1]\n +5'
static var points_25 = '[rainbow freq=1.0 sat=0.8 val=0.8][shake rate=20.0 level=5 connected = 1]\n +25'

static var string_neg = '[shake rate=20.0 level=5 connected = 1]\n '
static var string_pos = '[shake rate=20.0 level=5 connected = 1]\n +'
static var string_pos_over_20 = '[rainbow freq=1.0 sat=0.8 val=0.8][shake rate=20.0 level=5 connected = 1]\n +'

# Called when the node enters the scene tree for the first time.
func _ready():
	label_animation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func label_animation():
	var loops = score / 5
	
	var label_ani_time = 0.15
	var og_scale = label.scale
	var og_pos = label.global_position
	var og_rot = label.rotation
	
	
	if score <= 0: 
		label.text = str(string_neg, score) 
		
		var tween = create_tween()
		tween.tween_property(label, 'modulate', Color.WHITE, label_ani_time)
		tween.tween_property(label, 'global_position', Vector2(label.global_position[0], label.global_position[1]-20), label_ani_time)
		tween.tween_interval(1.0)
		tween.tween_callback(end_animation)
		
		
		return
	elif score >= 15: label.text = str(string_pos_over_20, score)
	else: label.text = str(string_pos, score)
	
	var tween = create_tween()
	tween.tween_property(firework_1, 'emitting', true, 0.0)
	tween.tween_callback(play_sfx)
	
	
	tween.tween_property(label, 'modulate', Color.WHITE, label_ani_time)
	tween.tween_property(label, 'global_position', Vector2(label.global_position[0], label.global_position[1]-20), label_ani_time)
	
	tween.tween_callback(play_points_sfx)
	
	tween.tween_property(label, 'scale', Vector2(label.scale[0]+0.2, label.scale[1]+0.2), label_ani_time)
	tween.parallel().tween_property(label, 'global_position', Vector2(label.global_position[0]-randf_range(20, 50), label.global_position[1]-randf_range(10, -10)), label_ani_time)
	tween.parallel().tween_property(label, 'rotation_degrees', randf_range(-12,-32), label_ani_time)
	
	tween.tween_property(label, 'scale', og_scale, label_ani_time)
	tween.parallel().tween_property(label, 'global_position', og_pos, label_ani_time)
	tween.parallel().tween_property(label, 'rotation_degrees', og_rot, label_ani_time)
	
	if loops >= 2: 
		tween.tween_property(firework_2, 'emitting', true, 0.0)
		tween.tween_callback(play_sfx)
		tween.tween_property(label, 'scale', Vector2(label.scale[0]-0.2, label.scale[1]-0.2), label_ani_time)
		tween.parallel().tween_property(label, 'global_position', Vector2(label.global_position[0]-randf_range(20, 50), label.global_position[1]-randf_range(10, -10)), label_ani_time)
		tween.parallel().tween_property(label, 'rotation_degrees', randf_range(-12,-32), label_ani_time)
	
		tween.tween_property(label, 'scale', og_scale, label_ani_time)
		tween.parallel().tween_property(label, 'global_position', og_pos, label_ani_time)
		tween.parallel().tween_property(label, 'rotation_degrees', og_rot, label_ani_time)
	
	
	
	tween.tween_callback(end_animation)
	

func end_animation():
	var tween = create_tween()
	tween.tween_property(label, 'modulate', Color.TRANSPARENT, 0.2)
	tween.tween_interval(0.8)
	tween.tween_callback(queue_free)

func play_sfx():
	var sfx_arr = [$sfx/firework1, $sfx/firework2, $sfx/firework3]
	
	for sfx in sfx_arr:
		if sfx.is_playing() == false: 
			sfx.volume_db = globvars.sfx_volume - 10
			sfx.play() 
			return
func play_points_sfx():
	
	var sfx = [$sfx/points1, $sfx/points2, $sfx/points3].pick_random()
	sfx.volume_db = globvars.sfx_volume - 10
	sfx.play()
