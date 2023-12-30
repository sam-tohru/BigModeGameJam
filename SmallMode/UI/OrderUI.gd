extends PanelContainer


@onready var parent = self.owner as SmallBoard

@onready var label_order = $OrderCC/VBox/LabelOrder
@onready var texture_0 = $OrderCC/VBox/OrderIcons/Texture0
@onready var texture_1 = $OrderCC/VBox/OrderIcons/Texture1
@onready var texture_2 = $OrderCC/VBox/OrderIcons/Texture2
@onready var label_mid_0 = $OrderCC/VBox/OrderIcons/LabelMid0
@onready var label_mid_1 = $OrderCC/VBox/OrderIcons/LabelMid1



@onready var texture_button = preload("res://SmallMode/Items/sprites/small/button1-small.png")
@onready var texture_fabric = preload("res://SmallMode/Items/sprites/small/cloth1-small.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	parent.updated_order.connect(updated_order)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if globvars.MODE != 'small': return



func updated_order(new_order: Array):
	if new_order.size() > 3: printerr('label updated order only does 3 arrays, change this')
	
	if new_order.size() == 1: label_order.text = str('Order ', parent.orders_done, ': ', new_order[0])
	elif new_order.size() == 2: label_order.text = str('Order ', parent.orders_done, ': ', new_order[0], ' & ', new_order[1])
	elif new_order.size() == 3: label_order.text = str('Order ', parent.orders_done, ': ', new_order[0], ' & ', new_order[1], ' & ', new_order[2])
	
	texture_0.visible = false
	texture_1.visible = false
	texture_2.visible = false
	label_mid_0.visible = false
	label_mid_1.visible = false
	# Sets textures, returns when size is done for that order
	match new_order[0]:
		'fabric': texture_0.texture = texture_fabric
		'button': texture_0.texture = texture_button
		_: printerr('NEED TO SET-UP OrderUI: ', new_order[0])
	
	texture_0.visible = true
	if new_order.size() == 1: return
	label_mid_0.visible = true
	
	match new_order[1]:
		'fabric': texture_1.texture = texture_fabric
		'button': texture_1.texture = texture_button
		_: printerr('NEED TO SET-UP OrderUI: ', new_order[1])
	
	texture_1.visible = true
	if new_order.size() == 2: return
	label_mid_1.visible = true
	
	match new_order[2]:
		'fabric': texture_2.texture = texture_fabric
		'button': texture_2.texture = texture_button
		_: printerr('NEED TO SET-UP OrderUI: ', new_order[2])
	
	texture_2.visible = true
	if new_order.size() == 3: return
	
	
	
