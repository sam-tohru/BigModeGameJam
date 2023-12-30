extends PanelContainer

@onready var ls_label = $MarginContainer/ls_hbox/ls_label
@onready var h_separator = $MarginContainer/ls_hbox/HSeparator

@onready var how_to_play = $MarginContainer/ls_hbox/HowToPlay
@onready var credits = $MarginContainer/ls_hbox/Credits


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_save_menu(visibility: bool, load_or_save: String):
	
	## On or Off
	self.visible = visibility
	
	
	## Load or Save
	ls_label.text = load_or_save
	
	if load_or_save == 'Credits':
		credits.visible = true
		how_to_play.visible = false
	else:
		credits.visible = false
		how_to_play.visible = true
