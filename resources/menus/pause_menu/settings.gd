extends PanelContainer


@onready var volume_slider = $MarginContainer/settings_hbox/volume_slider
@onready var sfxvol_slider = $MarginContainer/settings_hbox/sfxvol_slider


# Called when the node enters the scene tree for the first time.
func _ready():
	volume_slider.value = globvars.music_volume
	sfxvol_slider.value = globvars.sfx_volume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func settings_menu(visibility: bool):
	
	## On or Off
	self.visible = visibility
	
	## Disables / Enables all buttons & editables
	volume_slider.editable = visibility
	sfxvol_slider.editable = visibility



func _on_volume_slider_drag_ended(value_changed):
	globvars.music_volume = volume_slider.value
	globals.emit_signal('volume_changed')


func _on_sfxvol_slider_drag_ended(value_changed):
	globvars.sfx_volume = sfxvol_slider.value
	globals.emit_signal('volume_changed')
