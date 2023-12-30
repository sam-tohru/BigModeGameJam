extends Node2D

@onready var mode_goto_big = $ModeGotoBig
@onready var BigSwitch_pane = $ModeGotoBig/SwitchPane
@onready var BigSwitch_label = $ModeGotoBig/SwitchLabel

@onready var mode_goto_small = $ModeGotoSmall
@onready var SmallSwitch_pane = $ModeGotoSmall/SwitchPane
@onready var SmallSwitch_label = $ModeGotoSmall/SwitchLabel

@onready var girlsmall_big = $ModeGotoBig/GirlSmall
@onready var girlsmall_small = $ModeGotoSmall/GirlSmall

static var big_switch_label = ''

@onready var inflate_1 = $sfx/inflate1
@onready var inflate_2 = $sfx/inflate2
@onready var deflate_1 = $sfx/deflate1
@onready var deflate_2 = $sfx/deflate2

@onready var ba_1 = $sfx/ba_dum_ding/ba1
@onready var ba_2 = $sfx/ba_dum_ding/ba2
@onready var ba_3 = $sfx/ba_dum_ding/ba3
@onready var ba_4 = $sfx/ba_dum_ding/ba4



# Called when the node enters the scene tree for the first time.
func _ready():
	globals.switch_mode_changed.connect(switch_mode_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_mode_change_mode(): 
	if globvars.MODE == 'small': switch_to_bigmode(true)
	elif globvars.MODE == 'big': switch_to_smallmode(true)

func switch_mode_changed():
	if globvars.MODE == 'small': switch_to_smallmode()
	elif globvars.MODE == 'big': switch_to_bigmode()

func change_globvars_cant_change(go_to: bool = false):
	globvars.cant_change_modes = go_to

func switch_to_smallmode(switch: bool = false):
	if globvars.current_round == 0: return
	
	globvars.cant_change_modes = true
	var girl_scale = girlsmall_small.scale
	var girl_pos = girlsmall_small.global_position
	var pane_pos = SmallSwitch_pane.global_position
	
	var ani_time = globvars.pause_time_switch_modes/6
	var shrink_vect = Vector2(0.4, 0.4)
	var pane_move = Vector2(-30, 0)
	var girl_move = Vector2(-25, 0)
	
	mode_goto_small.visible = true
	girlsmall_small.visible = true
	
	play_shrink()
	var tween = create_tween()
	
	tween.tween_property(girlsmall_small, 'rotation_degrees', randf_range(-8,-14), ani_time)
	tween.parallel().tween_property(girlsmall_small, 'scale',  girlsmall_small.scale-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'global_position', girlsmall_small.global_position-girl_move, ani_time)
	tween.parallel().tween_property(SmallSwitch_pane, 'global_position', SmallSwitch_pane.global_position-pane_move, ani_time)
	
	tween.tween_property(girlsmall_small, 'rotation_degrees', 0, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'scale',  (girlsmall_small.scale-(shrink_vect))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'global_position', (girlsmall_small.global_position+(girl_move))-pane_move, ani_time)
	tween.parallel().tween_property(SmallSwitch_pane, 'global_position', (SmallSwitch_pane.global_position+(pane_move))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_small, 'rotation_degrees', randf_range(8,14), ani_time)
	tween.parallel().tween_property(girlsmall_small, 'scale',  (girlsmall_small.scale-(shrink_vect*2))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'global_position', (girlsmall_small.global_position+(girl_move*2))-pane_move, ani_time)
	tween.parallel().tween_property(SmallSwitch_pane, 'global_position', (SmallSwitch_pane.global_position+(pane_move*2))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_small, 'rotation_degrees', 0, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'scale',  (girlsmall_small.scale-(shrink_vect*3))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'global_position', (girlsmall_small.global_position+(girl_move*3))-pane_move, ani_time)
	tween.parallel().tween_property(SmallSwitch_pane, 'global_position', (SmallSwitch_pane.global_position+(pane_move*3))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_small, 'rotation_degrees',  randf_range(-8,-14), ani_time)
	tween.parallel().tween_property(girlsmall_small, 'scale',  (girlsmall_small.scale-(shrink_vect*4))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'global_position', (girlsmall_small.global_position+(girl_move*4))-pane_move, ani_time)
	tween.parallel().tween_property(SmallSwitch_pane, 'global_position', (SmallSwitch_pane.global_position+(pane_move*4))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_small, 'rotation_degrees', 0, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'scale',  (girlsmall_small.scale-(shrink_vect*5))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'global_position', (girlsmall_small.global_position+(girl_move*5))-pane_move, ani_time)
	tween.parallel().tween_property(SmallSwitch_pane, 'global_position', (SmallSwitch_pane.global_position+(pane_move*5))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_small, 'rotation_degrees', randf_range(8,14), ani_time)
	tween.parallel().tween_property(girlsmall_small, 'scale',  (girlsmall_small.scale-(shrink_vect*6))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'global_position', (girlsmall_small.global_position+(girl_move*6))-pane_move, ani_time)
	tween.parallel().tween_property(SmallSwitch_pane, 'global_position', (SmallSwitch_pane.global_position+(pane_move*6))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_small, 'rotation_degrees', 0, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'scale',  (girlsmall_small.scale-(shrink_vect*7))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_small, 'global_position', (girlsmall_small.global_position+(girl_move*7))-pane_move, ani_time)
	tween.parallel().tween_property(SmallSwitch_pane, 'global_position', (SmallSwitch_pane.global_position+(pane_move*7))-pane_move, ani_time)
	
	
	tween.tween_interval(0.2) ##################################################
	tween.tween_property(mode_goto_small, 'visible', false, 0.1)
	tween.parallel().tween_property(girlsmall_small, 'visible', false, 0.1)
	
	tween.tween_callback(change_globvars_cant_change)
	
	if switch: tween.tween_callback(globals.emit_signal.bind('switch_mode_from_animation'))
	
	# Reset
	tween.tween_property(girlsmall_small, 'scale', girl_scale, 0.1)
	tween.parallel().tween_property(girlsmall_small, 'global_position', girl_pos, 0.1)
	tween.parallel().tween_property(SmallSwitch_pane, 'global_position', pane_pos, 0.1)

func switch_to_bigmode(switch: bool = false):
	globvars.cant_change_modes = true
	var girl_scale = girlsmall_big.scale
	var girl_pos = girlsmall_big.global_position
	var pane_pos = BigSwitch_pane.global_position
	
	var ani_time = globvars.pause_time_switch_modes/6
	var shrink_vect = Vector2(-0.4, -0.4)
	var pane_move = Vector2(25, 0)
	var girl_move = Vector2(15, 0)
	
	mode_goto_big.visible = true
	girlsmall_big.visible = true
	
	play_grow()
	var tween = create_tween()
	
	tween.tween_property(girlsmall_big, 'rotation_degrees', randf_range(-18,-24), ani_time)
	tween.parallel().tween_property(girlsmall_big, 'scale',  girlsmall_big.scale-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_big, 'global_position', girlsmall_big.global_position-girl_move, ani_time)
	tween.parallel().tween_property(BigSwitch_pane, 'global_position', BigSwitch_pane.global_position-pane_move, ani_time)
	
	tween.tween_property(girlsmall_big, 'rotation_degrees', randf_range(18,24), ani_time)
	tween.parallel().tween_property(girlsmall_big, 'scale',  (girlsmall_big.scale-(shrink_vect))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_big, 'global_position', (girlsmall_big.global_position+(girl_move))-pane_move, ani_time)
	tween.parallel().tween_property(BigSwitch_pane, 'global_position', (BigSwitch_pane.global_position+(pane_move))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_big, 'rotation_degrees', randf_range(-18,-24), ani_time)
	tween.parallel().tween_property(girlsmall_big, 'scale',  (girlsmall_big.scale-(shrink_vect*2))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_big, 'global_position', (girlsmall_big.global_position+(girl_move*2))-pane_move, ani_time)
	tween.parallel().tween_property(BigSwitch_pane, 'global_position', (BigSwitch_pane.global_position+(pane_move*2))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_big, 'rotation_degrees', randf_range(18,24), ani_time)
	tween.parallel().tween_property(girlsmall_big, 'scale',  (girlsmall_big.scale-(shrink_vect*3))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_big, 'global_position', (girlsmall_big.global_position+(girl_move*3))-pane_move, ani_time)
	tween.parallel().tween_property(BigSwitch_pane, 'global_position', (BigSwitch_pane.global_position+(pane_move*3))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_big, 'rotation_degrees',  randf_range(-18,-24), ani_time)
	tween.parallel().tween_property(girlsmall_big, 'scale',  (girlsmall_big.scale-(shrink_vect*4))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_big, 'global_position', (girlsmall_big.global_position+(girl_move*4))-pane_move, ani_time)
	tween.parallel().tween_property(BigSwitch_pane, 'global_position', (BigSwitch_pane.global_position+(pane_move*4))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_big, 'rotation_degrees', randf_range(18,24), ani_time)
	tween.parallel().tween_property(girlsmall_big, 'scale',  (girlsmall_big.scale-(shrink_vect*5))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_big, 'global_position', (girlsmall_big.global_position+(girl_move*5))-pane_move, ani_time)
	tween.parallel().tween_property(BigSwitch_pane, 'global_position', (BigSwitch_pane.global_position+(pane_move*5))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_big, 'rotation_degrees', randf_range(-18,-24), ani_time)
	tween.parallel().tween_property(girlsmall_big, 'scale',  (girlsmall_big.scale-(shrink_vect*6))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_big, 'global_position', (girlsmall_big.global_position+(girl_move*6))-pane_move, ani_time)
	tween.parallel().tween_property(BigSwitch_pane, 'global_position', (BigSwitch_pane.global_position+(pane_move*6))-pane_move, ani_time)
	
	tween.tween_property(girlsmall_big, 'rotation_degrees', 0, ani_time)
	tween.parallel().tween_property(girlsmall_big, 'scale',  (girlsmall_big.scale-(shrink_vect*7))-shrink_vect, ani_time)
	tween.parallel().tween_property(girlsmall_big, 'global_position', (girlsmall_big.global_position+(girl_move*7))-pane_move, ani_time)
	tween.parallel().tween_property(BigSwitch_pane, 'global_position', (BigSwitch_pane.global_position+(pane_move*7))-pane_move, ani_time)
	
	
	tween.tween_interval(0.2) ##################################################
	tween.tween_property(mode_goto_big, 'visible', false, 0.1)
	tween.parallel().tween_property(girlsmall_big, 'visible', false, 0.1)
	
	tween.tween_callback(change_globvars_cant_change)
	
	if switch: tween.tween_callback(globals.emit_signal.bind('switch_mode_from_animation'))
	
	# Reset
	tween.tween_property(girlsmall_big, 'scale', girl_scale, 0.1)
	tween.parallel().tween_property(girlsmall_big, 'global_position', girl_pos, 0.1)
	tween.parallel().tween_property(BigSwitch_pane, 'global_position', pane_pos, 0.1)


func play_grow():
	
	
	if randi_range(1,2) == 1: inflate_1.volume_db = globvars.sfx_volume-30 ; inflate_1.play()
	else: inflate_2.volume_db = globvars.sfx_volume-30 ; inflate_2.play()
	
	var rando = randi_range(1,4)
	
	match rando:
		1: ba_1.volume_db = globvars.sfx_volume-5 ; ba_1.play()
		2: ba_2.volume_db = globvars.sfx_volume-5 ; ba_2.play()
		3: ba_3.volume_db = globvars.sfx_volume-5 ; ba_3.play()
		4: ba_4.volume_db = globvars.sfx_volume-5 ; ba_4.play()
		_: ba_1.volume_db = globvars.sfx_volume-5 ; ba_1.play()
	
func play_shrink():
	
	if randi_range(1,2) == 1: deflate_1.volume_db = globvars.sfx_volume-30 ; deflate_1.play()
	else: deflate_2.volume_db = globvars.sfx_volume-30 ; deflate_2.play()
	
	var rando = randi_range(1,4)
	
	match rando:
		1: ba_1.volume_db = globvars.sfx_volume-5 ; ba_1.play()
		2: ba_2.volume_db = globvars.sfx_volume-5 ; ba_2.play()
		3: ba_3.volume_db = globvars.sfx_volume-5 ; ba_3.play()
		4: ba_4.volume_db = globvars.sfx_volume-5 ; ba_4.play()
		_: ba_1.volume_db = globvars.sfx_volume-5 ; ba_1.play()
