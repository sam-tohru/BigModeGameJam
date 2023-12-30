extends Node2D

@onready var parent = get_parent() as SmallBoard

@onready var large = $large
@onready var small_top_l = $small_topL
@onready var small_top_r = $small_topR
@onready var small_bot_r = $small_botR
@onready var small_bot_l = $small_botL

@onready var when_they_come = $WhenTheyCome

@export var default_stomp_wait: float = 3.2
@export var round_between_time: float = 7.6

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if globvars.MODE != 'small' and !when_they_come.is_stopped(): when_they_come.stop()
	elif globvars.MODE == 'small' and when_they_come.is_stopped(): when_they_come.start()
	

func start_foot_stomp(what_foot: Area2D):
	
	var area_node = what_foot
	
	var thirds = default_stomp_wait / 3
	
	var tween = create_tween()
	tween.tween_property(area_node, 'modulate', Color.WHITE, thirds/2)
	tween.tween_property(area_node, 'modulate', Color.TRANSPARENT, thirds/2)
	
	tween.tween_property(area_node, 'modulate', Color.WHITE, thirds/2)
	tween.tween_property(area_node, 'modulate', Color.TRANSPARENT, thirds/2)
	
	tween.tween_property(area_node, 'modulate', Color.WHITE, thirds/2)
	
	tween.tween_callback(stomped.bind(area_node))
	tween.tween_callback(parent.emit_signal.bind('SFX_stomp'))
	tween.parallel().tween_callback(globals.emit_signal.bind('shake_the_camera', 'stomp_shake'))
	
	tween.tween_interval(0.8)
	tween.tween_property(area_node, 'modulate', Color.TRANSPARENT, thirds/2)

func stomped(area_node): # Game Over 
	if area_node.has_overlapping_bodies():
		parent.emit_signal('squashed_player')
		parent.game_over_small()


func _on_when_they_come_timeout():
	when_they_come.set_wait_time(round_between_time-(0.2*globvars.current_round))
	
	if globvars.current_round <= 1:
		return
	elif globvars.current_round <= 3:
		var rand_pick = [large, small_top_l, small_top_r, small_bot_r, small_bot_l].pick_random()
		start_foot_stomp(rand_pick)
	elif globvars.current_round <= 5: 
		var rand_pick = [small_top_l, small_top_r].pick_random()
		var rand_pick2 = [small_bot_r, small_bot_l].pick_random()
		
		start_foot_stomp(rand_pick)
		await get_tree().create_timer(0.3).timeout
		start_foot_stomp(rand_pick2)
		
		if randi_range(1,12) == 1: 
			await get_tree().create_timer(0.5).timeout
			start_foot_stomp(large)
		
	else:
		var rand_pick = [small_top_l, small_top_r].pick_random()
		var rand_pick2 = [small_bot_r, small_bot_l].pick_random()
		
		start_foot_stomp(rand_pick)
		await get_tree().create_timer(0.3).timeout
		start_foot_stomp(rand_pick2)
		
		if randi_range(1,12) <= 8: 
			await get_tree().create_timer(0.5).timeout
			start_foot_stomp(large)
