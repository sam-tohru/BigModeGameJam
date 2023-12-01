extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var motion = $GodotEssentialsMotion



func _physics_process(delta):
	## Get the input direction -> Normalized with helpers -> THIS IS FOR PLAYER CONTROL
	var direction = GodotEssentialsHelpers.normalize_vector(Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")))
	
	### Movement Stuff uses GodotEssentialsMotion -> if Accelerates or Decelerates than moves ###
	basic_move(direction)

func basic_move(move_direction: Vector2):
	move_direction = GodotEssentialsHelpers.normalize_vector(move_direction)
	if move_direction: motion.accelerate(move_direction)
	else: motion.decelerate()
	
	motion.move_and_collide()
