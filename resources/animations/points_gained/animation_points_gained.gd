extends Node2D

## This is the spawner / manager of the points gained animation
@onready var ani_preload = preload("res://resources/animations/points_gained/ANIpoints_gained.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.added_points.connect(spawn_points_ani)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func spawn_points_ani(how_much: int, pos: Vector2):
	var ani_child = ani_preload.instantiate()
	ani_child.score = how_much
	ani_child.global_position = pos
	call_deferred('add_child', ani_child)
