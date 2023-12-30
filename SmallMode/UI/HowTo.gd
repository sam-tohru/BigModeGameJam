extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globvars.current_round > 0: self.visible = false
	elif globvars.MODE == 'small' and globvars.current_points >= 10: self.visible = false
