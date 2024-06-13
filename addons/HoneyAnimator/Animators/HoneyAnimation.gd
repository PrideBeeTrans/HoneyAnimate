class_name HoneyAnimation
extends HoneyParameters

const _HoneyConstants := preload("res://addons/HoneyAnimator/Core/HoneyConstants.gd")

const EasingData := preload("res://addons/HoneyAnimator/Core/EasingData.tres").data.EasingData
const EasingNames := preload("res://addons/HoneyAnimator/Core/EasingData.tres").data.EasingNames


func process_animation(delta: float,from_sequence: bool = false) -> void:
	if _is_sequence() != from_sequence:
		return
	animation_process(delta)
	

func animation_process(delta: float) -> void:
	if _is_paused() == true:
		return
	
	if _has_delay() == true:
		_set_delay(_get_delay() - delta)
		if _is_delay_finished() == true:
			emit_signal("animation_delay_finished")
			if _get_on_delay_finished() != null:
				_get_on_delay_finished().call_func()
		return
	
	_handle_started()
	_handle_finished()
	
	if _is_finished() == true:
		return
	
	_set_elapsed_time(_get_elapsed_time() + delta * _get_speed_scale())
	_animation_step()


func _animation_step() -> void:
	pass


func _check_loop_type() -> void:
	pass


func _check_ease(time_normalized: float) -> float:
	if _get_ease() == null:
		_set_ease(EasingNames.EaseLinearInOut)
	
	elif _get_ease() is Curve:
		time_normalized = _get_ease().interpolate(_get_time_normalized())
	
	elif _get_ease() is String:
		var easings := _get_ease().split("_") as PoolStringArray
		var easing_name := "ease_%s" % easings[1]
		if easings.size() == 3:
			var ease_data := EasingData[easing_name] as Resource
			var ease_type := "ease_%s" % easings[2]
			time_normalized = funcref(ease_data, ease_type).call_func(_get_time_normalized())
		
		elif easings.size() == 4:
			var ease_data := EasingData[easing_name] as Resource
			var ease_type := "ease_%s_%s" % [easings[2],easings[3]]
			time_normalized = funcref(ease_data, ease_type).call_func(_get_time_normalized())
	
	elif _get_ease() is FuncRef:
		time_normalized = _get_ease().call_func(_get_time_normalized()) as float
	return time_normalized
