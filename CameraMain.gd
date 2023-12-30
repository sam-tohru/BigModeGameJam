extends Camera2D

@onready var shake_camera_component = $GodotEssentialsShakeCameraComponent2D

@onready var walk_shake = [1, 10]
@onready var stomp_shake = [4, 10]

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.shake_the_camera.connect(shake_the_camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shake_the_camera(what_shake: String):
	
	var shake_to_do:Array = []
	
	match what_shake:
		'walk_shake': shake_to_do = walk_shake
		'stomp_shake': shake_to_do = stomp_shake
		_: printerr('ERROR IN CAMERA, WHAT_SHAKE IS WRONG') ; return
	
	shake_camera_component.shake(shake_to_do[0], shake_to_do[1])
