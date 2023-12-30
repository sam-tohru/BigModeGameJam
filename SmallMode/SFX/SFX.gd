extends Node2D

@onready var parent = get_parent() as SmallBoard

@onready var needle_place_1 = $NeedlePlace1
@onready var needle_place_2 = $NeedlePlace2
@onready var needle_place_3 = $NeedlePlace3
@onready var encircling = $Encircling

@onready var walks = [$Walks/Walk1, $Walks/Walk2, $Walks/Walk3, $Walks/Walk4, $Walks/Walk5]

@onready var stomps = [$Stomps/Stomp1, $Stomps/Stomp2, $Stomps/Stomp3, $Stomps/Stomp4]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if encircling.is_playing(): # Checks if left is_drawing, if not stops audio
		if parent.capture_area.is_drawing == false: encircling.stop()


func _on_small_main_sfx_place(go_to: bool):
	
	if go_to == false:
		if encircling.is_playing(): 
			encircling.stop()
			return
	
	var pick_one = randi_range(1,3)
	match pick_one:
		1: needle_place_1.play()
		2: needle_place_2.play()
		3: needle_place_3.play()
	encircling.play()





func _on_small_main_sfx_walk():
	var rand_walk = walks.pick_random()
	if rand_walk.is_playing(): rand_walk = walks.pick_random()
	if rand_walk.is_playing(): # Loops through if 2nd was playing, until finds one that isn't & returns
		for walk in walks:
			if walk.is_playing(): walk.volume_db = globvars.sfx_volume-10 ; walk.play() ; return
		return
	
	rand_walk.volume_db = globvars.sfx_volume-10
	rand_walk.play()


func _on_small_main_sfx_stomp():
	var rand_stomp = stomps.pick_random()
	if rand_stomp.is_playing(): rand_stomp = stomps.pick_random()
	if rand_stomp.is_playing(): # Loops through if 2nd was playing, until finds one that isn't & returns
		for stomp in stomps:
			if stomp.is_playing(): stomp.volume_db = globvars.sfx_volume-15 ; stomp.play() ; return
		return
	
	rand_stomp.volume_db = globvars.sfx_volume-15 
	rand_stomp.play()
