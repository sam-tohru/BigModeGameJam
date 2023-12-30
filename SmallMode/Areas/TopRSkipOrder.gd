extends Area2D

@onready var can_do: bool = true
@onready var wait_time: float = 0.4

@onready var parent = self.owner as SmallBoard


@onready var player_in_area: bool = false
@onready var how_to_label = $HowToLabel

@onready var rich_text_label = $RichTextLabel

static var spawn_string = '\nSkip Order'
static var spawn_wave_string = '[wave amp=50.0 freq=25.0 connected=1]\nSkip Order[/wave]'


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if player_in_area: how_to_label.visible = true
	else: how_to_label.visible = false

func _input(event):
	if event.is_action_pressed('r_click') and player_in_area:
		if can_do and globvars.MODE == 'small':
			skip_order()
			can_do = false
			await get_tree().create_timer(wait_time).timeout
			can_do = true

func player_is_in_area() -> bool:
	
	return player_in_area
	
	if self.has_overlapping_bodies():
		for body in self.get_overlapping_bodies():
			if body.is_in_group('PlayerSmall'): return true
	
	return false

func skip_order():
	# How to determine what_to_spawn: String for spawn_item
	parent.order_system.order_skipped()
	
	rich_text_label.text = spawn_wave_string
	await get_tree().create_timer(wait_time).timeout
	rich_text_label.text = spawn_string


func _on_body_entered(body):
	if self.has_overlapping_bodies():
		for bod in self.get_overlapping_bodies():
			if bod.is_in_group('PlayerSmall'): player_in_area = true


func _on_body_exited(body): # Only player body triggers is
	player_in_area = false


func _on_color_rect_mouse_entered():
	player_in_area = true


func _on_color_rect_mouse_exited():
	
	if self.has_overlapping_bodies(): # Checks if actal body in, if so returns
		for bod in self.get_overlapping_bodies():
			if bod.is_in_group('PlayerSmall'): return
		
	player_in_area = false
