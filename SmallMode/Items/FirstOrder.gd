extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globvars.current_round != 0 or globvars.current_points >= 10:
		self.queue_free()
	else:
		if globvars.current_order.has(get_parent().item_type): self.visible = true
		else: self.visible = false
