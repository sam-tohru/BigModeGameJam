extends AnimatedSprite2D

@onready var mouse_inside: bool = false
@onready var is_switching: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_girl_sprite():
	is_switching = true
	var og_scale = self.scale
	var tween = create_tween()
	tween.tween_property(self, 'rotation_degrees', randi_range(-28,28), 0.05)
	tween.parallel().tween_property(self, 'scale', Vector2(og_scale[0]+0.2, og_scale[1]+0.2), 0.05)
	tween.tween_callback(random_sprite_change)
	tween.tween_callback(globals.emit_signal.bind('SFX_big_sprite_change'))
	tween.tween_property(self, 'rotation_degrees', 0, 0.05)
	tween.parallel().tween_property(self, 'scale', og_scale, 0.05)
	tween.tween_callback(change_is_switching_back)

func random_sprite_change():
	var anis = ['A', 'D', 'S', 'W', 'default']
	self.animation = anis.pick_random()

func change_is_switching_back():
	is_switching = false

func _input(event):
	if event.is_action_pressed("l_click") and mouse_inside and !is_switching: 
		
		switch_girl_sprite()

func _on_area_2d_mouse_entered():
	mouse_inside = true


func _on_area_2d_mouse_exited():
	mouse_inside = false
