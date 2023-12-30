extends Node


## Global Variables
@onready var music_volume: float = 0.0
@onready var sfx_volume: float = 0.0

@onready var player_in_game_menu: bool = false # if player is in an in_game_menu (not the main_menu)

@onready var cant_change_modes: bool = false
@onready var MODE: String = 'small'
@onready var pause_time_switch_modes: float = 1.5

@onready var play_is_dead: bool = false

@onready var current_order: Array = []
@export var current_round: int = 0
@export var current_points: int = 0

@onready var small_orders_done: int = 0

@export_enum('fabric', 'button') var item_type: String
@onready var item_dictionary = {
	'fabric': [0],
	'button': [0]
}


@export_enum('white', 'red', 'blue') var current_color: String
static var colors_dictionary = {
	'white': Color('e3cfb4'),
	'red': Color('b03a48'),
	'blue': Color('243d5c'),
}
