extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	finished.connect(finished_playing)
	globals.volume_changed.connect(volume_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func finished_playing():
	await get_tree().create_timer(1.0).timeout
	self.play()


func volume_changed():
	self.volume_db = globvars.music_volume
