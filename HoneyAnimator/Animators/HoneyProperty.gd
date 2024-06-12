class_name HoneyProperty
extends HoneyAnimation


var _property := NodePath() setget _set_property,_get_property
var _from setget _set_from,_get_from
var _to setget _set_to,_get_to
var _is_from := true setget _set_is_from,_get_is_from
var _as_relative := false setget _set_to,_get_to


func _init(node: Node) -> void:
	_set_target(node)
	_set_from(_get_target().get_indexed(_get_property()))


func anima_property(property: NodePath,to_value,duration: float) -> HoneyProperty:
	_set_property(property)
	
	if _get_is_from() == true:
		_set_from(_get_target().get_indexed(_get_property()))
	
	
	if _get_as_relative() == true:
		_set_from(_get_from() + _get_to())
	_set_to(to_value)
	_set_duration(duration)
	return self


func _animation_step() -> void:
	var time_normalized := _check_ease(_get_time_normalized()) as float
	var animation_value = _get_from() + (_get_to() - _get_from()) * time_normalized * _get_time_direction()
	if _get_on_step() != null:
		_get_on_step().call_funcv([animation_value])
	_set_target_property(_get_property(), animation_value)
	emit_signal("animation_step", animation_value)


func _check_loop_type() -> void:
	if _get_loop_type() == LoopType.Restart:
		_set_target_property(_get_property(), _get_from())
	elif _get_loop_type() == LoopType.Yoyo:
		var old_from = _get_from()
		var old_to = _get_to()
		_set_to(old_from)
		_set_from(old_to)
		_set_target_property(_get_property(), _get_from())


func _set_target_property(property: String,value) -> void:
	_get_target().set_indexed(property, value)


func from(value) -> HoneyProperty:
	_set_from(value)
	_set_is_from(false)
	return self


func from_current() -> HoneyProperty:
	_set_from(_get_target().get_indexed(_get_property()))
	_set_is_from(false)
	return self


func update_from() -> HoneyProperty:
	_set_from(_get_target().get_indexed(_get_property()))
	return self


func set_parameters(value: HoneyParameters) -> HoneyProperty:
	set_ease(value._get_ease())
	set_delay(value._get_delay())
	return self


func play() -> HoneyProperty:
	_handle_started()
	return self


func set_speed_scale(value: float) -> HoneyProperty:
	_set_speed_scale(value)
	return self


func set_delay(value: float) -> HoneyProperty:
	_set_delay(value)
	_set_initial_delay(value)
	return self


func set_initial_delay(value: float) -> HoneyProperty:
	_set_initial_delay(value)
	return self


func set_loops(value: int,loop_type: String = LoopType.Restart) -> HoneyProperty:
	_set_loop_count(value)
	_set_loop_type(loop_type)
	return self
	
	
func paused() -> HoneyProperty:
	_set_paused(true)
	emit_signal("animation_paused")
	return self


func resume() -> HoneyProperty:
	_set_paused(false)
	return self


func on_started(func_ref: FuncRef) -> HoneyProperty:
	_set_on_started(func_ref)
	return self


func on_step(func_ref: FuncRef) -> HoneyProperty:
	_set_on_step(func_ref)
	return self


func on_running(func_ref: FuncRef) -> HoneyProperty:
	_set_on_running(func_ref)
	return self


func on_finished(func_ref: FuncRef) -> HoneyProperty:
	_set_on_finished(func_ref)
	return self


func on_loop_finished(func_ref: FuncRef) -> HoneyProperty:
	_set_on_loop_finished(func_ref)
	return self


func on_infinity_loop_finished(func_ref: FuncRef) -> HoneyProperty:
	_set_on_infinity_loop_finished(func_ref)
	return self


func on_delay_finished(func_ref: FuncRef) -> HoneyProperty:
	_set_on_delay_finished(func_ref)
	return self


func on_rewind(func_ref: FuncRef) -> HoneyProperty:
	_set_on_rewind(func_ref)
	return self


func on_paused(func_ref: FuncRef) -> HoneyProperty:
	_set_on_paused(func_ref)
	return self


func on_flip(func_ref: FuncRef) -> HoneyProperty:
	_set_on_flip(func_ref)
	return self


func reset() -> HoneyProperty:
	_set_started(false)
	_set_playing(false)
	_set_finished(false)
	_set_paused(false)
	_set_elapsed_time(EmptyTime)
	_handle_loop_type()
	_set_delay(_get_initial_delay())
	return self


func set_ease(value) -> HoneyProperty:
	_set_ease(value)
	return self


func _set_property(value: NodePath) -> void:
	_property = value


func _get_property() -> NodePath:
	return _property


func _set_from(value) -> void:
	_from = value


func _get_from():
	return _from


func _set_to(value) -> void:
	_to = value


func _get_to():
	return _to


func _set_is_from(value: bool) -> void:
	_is_from = value


func _get_is_from() -> bool:
	return _is_from


func _set_as_relative(value: bool) -> void:
	_as_relative = value


func _get_as_relative() -> bool:
	return _as_relative
