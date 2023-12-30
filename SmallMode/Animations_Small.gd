extends Node2D

@onready var parent = get_parent() as SmallBoard

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_small_main_updated_order(_current_order):
	var order_icons = $"../UI/OrderUI/OrderCC/VBox/OrderIcons"
	var og_scale = order_icons.scale
	var tween = create_tween()
	tween.tween_property(order_icons, 'scale', Vector2(order_icons.scale[0]+0.2, order_icons.scale[1]+0.2), 0.1)
	tween.tween_property(order_icons, 'scale', og_scale, 0.1)



func _on_small_main_small_incorrect_order():
	var order_icons = $"../UI/OrderUI/OrderCC/VBox/OrderIcons"
	var order_ui = $"../UI/OrderUI"
	var og_scale = order_icons.scale
	var og_ui_scale = order_ui.scale
	var tween = create_tween()
	tween.tween_property(order_icons, 'scale', Vector2(order_icons.scale[0]+0.4, order_icons.scale[1]+0.4), 0.2)
	tween.parallel().tween_property(order_ui, 'scale', Vector2(order_icons.scale[0]+0.1, order_icons.scale[1]+0.1), 0.2)
	tween.tween_property(order_icons, 'scale', og_scale, 0.2)
	tween.parallel().tween_property(order_ui, 'scale', og_ui_scale, 0.2)
	tween.tween_property(order_icons, 'scale', Vector2(order_icons.scale[0]+0.4, order_icons.scale[1]+0.4), 0.2)
	tween.parallel().tween_property(order_ui, 'scale', Vector2(order_icons.scale[0]+0.1, order_icons.scale[1]+0.1), 0.2)
	tween.tween_property(order_icons, 'scale', og_scale, 0.2)
	tween.parallel().tween_property(order_ui, 'scale', og_ui_scale, 0.2)
	tween.tween_property(order_icons, 'scale', Vector2(order_icons.scale[0]+0.4, order_icons.scale[1]+0.4), 0.2)
	tween.parallel().tween_property(order_ui, 'scale', Vector2(order_icons.scale[0]+0.1, order_icons.scale[1]+0.1), 0.2)
	tween.tween_property(order_icons, 'scale', og_scale, 0.2)
	tween.parallel().tween_property(order_ui, 'scale', og_ui_scale, 0.2)
	tween.tween_property(order_icons, 'scale', Vector2(order_icons.scale[0]+0.4, order_icons.scale[1]+0.4), 0.2)
	tween.parallel().tween_property(order_ui, 'scale', Vector2(order_icons.scale[0]+0.1, order_icons.scale[1]+0.1), 0.2)
	tween.tween_property(order_icons, 'scale', og_scale, 0.2)
	tween.parallel().tween_property(order_ui, 'scale', og_ui_scale, 0.2)
