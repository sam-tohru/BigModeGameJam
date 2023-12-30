extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_big_main_update_order_ui(new_order: Array):
	var to_do_label = $OrderUI/OrderCC/VBox/ToDoLabel
	
	if new_order.is_empty(): to_do_label.text = '' ; return
	
	var order_string = str(new_order[0].capitalize())
	var i = 1
	while i < new_order.size():
		# Checks if last item in array (so no comma)
		# if i == new_order.size()-1: order_string = order_string + str(new_order[i])
		order_string = order_string + str(', ', new_order[i].capitalize())
		i += 1
	
	#to_do_label.text = order_string
	
	var og_scale = to_do_label.scale
	var tween = create_tween()
	tween.tween_property(to_do_label, 'scale', Vector2(og_scale[0]+0.15,og_scale[1]+0.15),0.05)
	tween.tween_property(to_do_label, 'text', order_string,0.01)
	tween.tween_property(to_do_label, 'scale', Vector2(og_scale[0],og_scale[1]),0.05)
