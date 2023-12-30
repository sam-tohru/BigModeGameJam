extends Node2D


@onready var girl_sprite = $AnimatedSprite2D


@onready var parent = get_parent() as BigMain


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if !parent.switch_timer.is_stopped(): return
	elif !parent.switch_timer_get_input.is_stopped(): # Returns
		if event.is_action_pressed("ui_left"): parent.give_input('left')
		elif event.is_action_pressed("ui_right"): parent.give_input('right')
		elif event.is_action_pressed("ui_up"): parent.give_input('up')
		elif event.is_action_pressed("ui_down"): parent.give_input('down')
		return
	
	if event.is_action_pressed("ui_left"):
		parent.give_input('left')
		parent.switch_timer.start()
		animation_switch('A')
		#girl_sprite.animation = 'FrontR'
	elif event.is_action_pressed("ui_right"): 
		parent.give_input('right')
		parent.switch_timer.start()
		animation_switch('D')
		#girl_sprite.animation = 'BackR'
	elif event.is_action_pressed("ui_up"): 
		parent.give_input('up')
		parent.switch_timer.start()
		animation_switch('W')
		#girl_sprite.animation = 'BackL'
	elif event.is_action_pressed("ui_down"): 
		parent.give_input('down')
		parent.switch_timer.start()
		animation_switch('S')
		#girl_sprite.animation = 'FrontL'

func switch_girl_to(go_to_ani: String):
	parent.switch_timer.start()
	animation_switch(go_to_ani)

func animation_switch(go_to_ani: StringName):
	
	var orig_scale = girl_sprite.scale
	var ani_time = 0.05 #parent.switch_timer.wait_time
	var ani_time_2 = 0.05 #parent.switch_timer_get_input.wait_time
	
	var tween = create_tween()
	tween.tween_property(girl_sprite, 'scale', Vector2(girl_sprite.scale[0]-0.2, girl_sprite.scale[1]+0.2), ani_time)
	tween.parallel().tween_property(girl_sprite, 'rotation_degrees', randf_range(-32, 32), ani_time/2)
	
	tween.tween_property(girl_sprite, 'animation', go_to_ani, 0.0)
	tween.tween_callback(globals.emit_signal.bind('SFX_big_sprite_change'))
	
	tween.tween_property(girl_sprite, 'scale', orig_scale, ani_time_2)
	tween.parallel().tween_property(girl_sprite, 'rotation_degrees', 0, ani_time_2)
	
