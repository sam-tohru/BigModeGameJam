extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready():
	globals.SFX_big_sprite_change.connect(SFX_big_sprite_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SFX_big_sprite_change():
	var bonks = [$bonk1, $bonk2, $bonk3]
	var rand_bonk = bonks.pick_random()
	
	if rand_bonk.is_playing(): rand_bonk = bonks.pick_random()
	if rand_bonk.is_playing(): # Loops through if 2nd was playing, until finds one that isn't & returns
		for bonk in bonks:
			if !is_instance_valid(bonk): return
			if bonk.is_playing(): bonk.volume_db = globvars.sfx_volume-30 ; bonk.play() ; return
		return
	
	rand_bonk.volume_db = globvars.sfx_volume-30
	rand_bonk.play()
