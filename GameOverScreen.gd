extends PanelContainer

@onready var restart_button = $VBoxContainer/HBoxContainer/RestartButton
@onready var menu_button = $VBoxContainer/HBoxContainer/MenuButton

@onready var label_points = $VBoxContainer/LabelPoints

# Called when the node enters the scene tree for the first time.
func _ready():
	
	globals.game_over.connect(switch_on)
	
	restart_button.pressed.connect(func(): globals.emit_signal('restart_game') ; switch_off()) # Restarts & Switches self off
	menu_button.pressed.connect(func(): globals.emit_signal('main_button_pressed') ; switch_off()) # turn
	

func switch_off():
	self.visible = false
	restart_button.disabled = true
	menu_button.disabled = true

func switch_on():
	if globvars.MODE == 'dead': return
	globvars.MODE = 'dead'
	
	label_points.text = str(globvars.current_points, ' Points')
	
	if !globvars.play_is_dead: $VBoxContainer/LabelSurvived.visible = true
	
	self.visible = true
	restart_button.disabled = false
	menu_button.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

