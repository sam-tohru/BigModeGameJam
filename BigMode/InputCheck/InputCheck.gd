extends Node



func _input(event):
	if event.is_action_pressed("ui_left"):print('left')
	elif event.is_action_pressed("ui_right"): print('right')
	elif event.is_action_pressed("ui_up"): print('up')
	elif event.is_action_pressed("ui_down"): print('down')

