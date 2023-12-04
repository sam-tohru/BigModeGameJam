extends Node


## Global Variables

@onready var player_in_game_menu: bool = false # if player is in an in_game_menu (not the main_menu)


@export_enum('fabric', 'button') var item_type: String
@onready var item_dictionary = {
	'fabric': [],
	'button': []
}


@export_enum('white', 'red', 'blue') var current_color: String
static var colors_dictionary = {
	'white': Color('e3cfb4'),
	'red': Color('b03a48'),
	'blue': Color('243d5c'),
}
