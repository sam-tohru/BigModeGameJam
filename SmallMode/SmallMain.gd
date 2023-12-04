extends Node2D
class_name SmallBoard

signal updated_order
signal check_order

@onready var player_small = $PlayerSmall
@onready var capture_area = $Capture_Area

@onready var order_system = $OrderSystem

@onready var MatGoToAreas = [$Background/MaterialGoToAreas/Marker2D, $Background/MaterialGoToAreas/Marker2D2, $Background/MaterialGoToAreas/Marker2D3, $Background/MaterialGoToAreas/Marker2D4, $Background/MaterialGoToAreas/Marker2D5, $Background/MaterialGoToAreas/Marker2D6, $Background/MaterialGoToAreas/Marker2D7, $Background/MaterialGoToAreas/Marker2D8, $Background/MaterialGoToAreas/Marker2D9, $Background/MaterialGoToAreas/Marker2D10, $Background/MaterialGoToAreas/Marker2D11]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
