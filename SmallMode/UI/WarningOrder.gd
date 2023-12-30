extends Label

@onready var is_playing: bool = false

@onready var parent = self.owner as SmallBoard

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globvars.current_round == 2 and !is_playing: 
		play_warning()
	elif globvars.current_round > 2:
		stop_warning()
	

func play_warning():
	is_playing = true
	
	var tween = create_tween()
	tween.tween_property(self, 'modulate', Color.WHITE, 0.1)
	tween.parallel().tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_property(self, 'position', Vector2(position[0]+20, position[1]), 0.1)
	tween.tween_property(self, 'position', Vector2(position[0]-20, position[1]), 0.1)
	
	tween.tween_interval(3.8)
	tween.tween_property(self, 'modulate', Color.TRANSPARENT, 0.1)

func stop_warning():
	self.queue_free()


