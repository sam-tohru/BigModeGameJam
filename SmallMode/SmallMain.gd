extends Node2D
class_name SmallBoard

signal updated_order
signal check_order
signal small_incorrect_order

signal SFX_place
signal SFX_walk
signal SFX_stomp

signal squashed_player

@onready var player_small = $PlayerSmall
@onready var capture_area = $Capture_Area

@onready var order_system = $OrderSystem
@onready var spawner = $Spawner


@onready var MatGoToAreas = [$Background/MaterialGoToAreas/Marker2D, $Background/MaterialGoToAreas/Marker2D2, $Background/MaterialGoToAreas/Marker2D3, $Background/MaterialGoToAreas/Marker2D4, $Background/MaterialGoToAreas/Marker2D5, $Background/MaterialGoToAreas/Marker2D6]

@export var orders_to_do: int = 11
@onready var orders_done: int = 0

@onready var round_timer = $RoundTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	globals.switch_mode_changed.connect(switch_mode_animation)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over_small():
	globvars.play_is_dead = true
	globals.emit_signal('game_over')

func switch_mode_animation(): ## Signal called after globvars.MODE change
	if globvars.MODE == 'small': # Brings back
		
		if globvars.current_round == 0: round_timer.wait_time = 30.0
		elif globvars.current_round == 1: round_timer.wait_time = 25.0
		elif globvars.current_round == 4: round_timer.wait_time = 30.0
		
		round_timer.start()
		order_system.generate_random_order()
		
		if globvars.current_round == 0: spawner.spawn_item();  spawner.spawn_item(); return
		
		self.scale = Vector2(0.4,0.4)
		var tween = create_tween()
		tween.tween_property(self, 'modulate', Color.WHITE, 0.2)
		tween.parallel().tween_property(self, 'scale', Vector2(1.0,1.0), 0.2)
		tween.tween_callback(spawner.spawn_item)
		tween.tween_interval(0.1)
		tween.tween_callback(spawner.spawn_item)
	else: # Goes away (Checks if completed enough orders)
		round_timer.stop()
		globvars.small_orders_done = orders_done
		
		var tween = create_tween()
		tween.tween_property(self, 'modulate', Color.TRANSPARENT, 0.2)
		tween.parallel().tween_property(self, 'scale', Vector2(0.6,0.6), 0.2)
		
		# Sets back to normal scale after not visible
		tween.tween_property(self, 'scale', Vector2(1.0,1.0), 0.05)

func reset_small_main():
	round_timer.start()
	order_system.generate_random_order()
	
	# if globvars.current_round == 0: spawner.spawn_item();  spawner.spawn_item(); return
	
	self.scale = Vector2(0.4,0.4)
	var tween = create_tween()
	tween.tween_property(self, 'modulate', Color.WHITE, 0.2)
	tween.parallel().tween_property(self, 'scale', Vector2(1.0,1.0), 0.2)
	tween.tween_callback(spawner.spawn_item)
	tween.tween_interval(0.1)
	tween.tween_callback(spawner.spawn_item)

func _on_round_timer_timeout():
	globals.emit_signal('small_orders_done')
