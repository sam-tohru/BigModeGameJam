extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var blood = preload("res://resources/animations/blood/blood.tscn")

@onready var direction = Vector2.ZERO

@onready var motion = $GodotEssentialsMotion

@onready var sprite_girl_small = $SpriteGirlSmall
@onready var needle_sprite = $SpriteGirlSmall/NeedleSprite

@onready var move_ani_playing: bool = false

@onready var parent = get_parent() as SmallBoard

func _ready():
	globals.restart_game.connect(reset_player)

func _physics_process(delta):
	if globvars.MODE != 'small': return
	
	## Get the input direction -> Normalized with helpers -> THIS IS FOR PLAYER CONTROL
	direction = GodotEssentialsHelpers.normalize_vector(Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")))
	
	### Movement Stuff uses GodotEssentialsMotion -> if Accelerates or Decelerates than moves ###
	basic_move(direction)
	change_sprite_direction()
	if !move_ani_playing:  move_animation()
	
	if Input.is_action_pressed("l_click") and parent.capture_area.is_drawing: 
		needle_sprite.visible = false
	elif !needle_sprite.visible: 
		needle_sprite.visible = true

func basic_move(move_direction: Vector2):
	move_direction = GodotEssentialsHelpers.normalize_vector(move_direction)
	if move_direction: motion.accelerate(move_direction)
	else: motion.decelerate()
	
	motion.move_and_collide()

func move_animation():
	if globvars.MODE != 'small': return
	
	if direction[0] == 0 and direction[1] == 0:
		return
	
	var ani_length = 0.4
	var quart_time = ani_length / 4
	move_ani_playing = true
	
	var scale0 = sprite_girl_small.scale[0]
	var scale1 = sprite_girl_small.scale[1]
	
	var tween = create_tween()
	tween.tween_property(sprite_girl_small, 'rotation_degrees', randf_range(-13, -26), quart_time)
	tween.parallel().tween_property(sprite_girl_small, 'scale', Vector2(scale0-0.02, scale1+0.02), quart_time)
	
	tween.tween_property(sprite_girl_small, 'rotation_degrees', 0, quart_time)
	tween.parallel().tween_property(sprite_girl_small, 'scale', Vector2(scale0, scale1), quart_time)
	
	tween.tween_callback(parent.emit_signal.bind('SFX_walk'))
	tween.parallel().tween_callback(globals.emit_signal.bind('shake_the_camera', 'walk_shake'))
	
	tween.tween_property(sprite_girl_small, 'rotation_degrees', randf_range(8, 16), quart_time)
	tween.parallel().tween_property(sprite_girl_small, 'scale', Vector2(scale0+0.02, scale1-0.02), quart_time)
	
	tween.tween_property(sprite_girl_small, 'rotation_degrees', 0, quart_time)
	tween.parallel().tween_property(sprite_girl_small, 'scale', Vector2(scale0, scale1), quart_time)
	
	
	tween.tween_callback(func(): move_ani_playing=false)
	tween.tween_callback(move_animation)
func end_move_ani():
	move_ani_playing = false

func change_sprite_direction():
	var what_to = 'FrontL'
	
	if Input.is_action_pressed("ui_up"):
		if Input.is_action_pressed("ui_left"): what_to = 'BackL'
		else: what_to = 'BackR'
	else:
		if Input.is_action_pressed("ui_left"): what_to = 'FrontR'
		else: what_to = 'FrontL'
	
	$SpriteGirlSmall/GirlSprite.animation = what_to
	$SpriteGirlSmall/NeedleSprite.animation = what_to


func reset_player():
	sprite_girl_small.skew = 0

func _on_small_main_squashed_player():
	
	var tween = create_tween()
	tween.tween_property(sprite_girl_small, 'skew', 36, 0.01)
	
	var blood_instance = blood.instantiate()
	get_tree().get_root().call_deferred("add_child", blood_instance)
	blood_instance.global_position = self.global_position
	
	await get_tree().create_timer(1.0).timeout
	
