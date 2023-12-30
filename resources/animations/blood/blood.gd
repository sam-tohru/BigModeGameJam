extends CPUParticles2D

@onready var remove_timer = $RemoveTimer

func _on_timer_timeout():
	remove_timer.start()
	set_process_internal(false)


func _on_remove_timer_timeout():
	var tween = create_tween()
	tween.tween_property(self, 'modulate', Color.TRANSPARENT, 0.3)
	tween.tween_callback(queue_free)
