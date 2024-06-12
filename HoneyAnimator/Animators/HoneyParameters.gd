class_name HoneyParameters
extends Reference

signal animation_started()
signal animation_step(value)
signal animation_finished()
signal animation_loop_finished(loop_count)
signal animation_infinity_loop_finished(loop_count)
signal animation_delay_finished()
signal animation_rewind()
signal animation_paused()
signal animation_flip()

const LoopType := {"Restart":"Restart","Yoyo":"Yoyo"}
const TimeDirection := {"Left":-1.0,"Right":1.0}

const EmptyTime := 0.0
const SpeedScaleDefault := 1.0

var _ease = null setget _set_ease,_get_ease
var _id = null setget _set_id,_get_id

var _target : Object = null setget _set_target,_get_target

var _elapsed_time := EmptyTime setget _set_elapsed_time,_get_elapsed_time
var _duration := EmptyTime setget _set_duration,_get_duration
var _delay := EmptyTime setget _set_delay,_get_delay
var _initial_delay := EmptyTime setget _set_initial_delay,_get_initial_delay
var _speed_scale := SpeedScaleDefault setget _set_speed_scale,_get_speed_scale

var _time_direction := TimeDirection.Right as float setget _set_time_direction,_get_time_direction

var _started := false setget _set_started,_get_started
var _playing := false setget _set_playing,_get_playing
var _paused := false setget _set_paused,_get_paused
var _finished := false setget _set_finished,_get_finished
var _sequence := false setget _set_sequence,_get_sequence

var _loop_count := 0 setget _set_loop_count,_get_loop_count
var _loop_type := LoopType.Restart as String setget _set_loop_type,_get_loop_type

var _on_started : FuncRef setget _set_on_started,_get_on_started
var _on_step : FuncRef setget _set_on_step,_get_on_step
var _on_running : FuncRef setget _set_on_running,_get_on_running
var _on_finished : FuncRef setget _set_on_finished,_get_on_finished
var _on_loop_finished : FuncRef setget _set_on_loop_finished,_get_on_loop_finished
var _on_infinity_loop_finished : FuncRef setget _set_on_infinity_loop_finished,_get_on_infinity_loop_finished
var _on_delay_finished : FuncRef setget _set_on_delay_finished,_get_on_delay_finished
var _on_rewind : FuncRef setget _set_on_rewind,_get_on_rewind
var _on_paused : FuncRef setget _set_on_paused,_get_on_paused
var _on_flip : FuncRef setget _set_on_flip,_get_on_flip


func play():
	_handle_started()
	return self


func set_speed_scale(value: float):
	_set_speed_scale(value)
	return self


func set_delay(value: float):
	_set_delay(value)
	_set_initial_delay(value)
	return self


func set_loops(value: int,loop_type: String = LoopType.None):
	_set_loop_count(value)
	_set_loop_type(loop_type)
	return self


func set_ease(value):
	_set_ease(value)
	return self
	
	
func paused():
	_set_paused(true)
	if _get_on_paused() != null:
		_get_on_paused().call_func()
	emit_signal("animation_paused")
	return self


func resume():
	_set_paused(false)
	return self


func reset():
	_set_started(false)
	_set_playing(false)
	_set_finished(false)
	_set_paused(false)
	_set_elapsed_time(EmptyTime)
	_handle_loop_type()
	_set_delay(_get_initial_delay())
	return self


func flip() -> void:
	_set_elapsed_time(_get_duration() - _get_elapsed_time())
	_set_time_direction(-_get_time_direction())
	if _get_on_flip() != null:
		_get_on_flip().call_func()
	emit_signal("animation_flip")


func play_backwards() -> void:
	_set_time_direction(TimeDirection.Left)
	if _is_paused():
		resume()


func play_forward() -> void:
	_set_time_direction(TimeDirection.Right)
	if _is_paused():
		resume()


func restart(include_delay: bool = true, change_delay_to: float = -1.0) -> void:
	reset()
	if include_delay:
		if change_delay_to >= 0.0:
			_set_delay(change_delay_to)
		else:
			_set_delay(_get_initial_delay())
	else:
		_set_delay(0.0)
	resume()


func rewind(include_delay: bool = true) -> void:
	if include_delay:
		_set_elapsed_time(_get_delay())
	else:
		_set_elapsed_time(0.0)
	_set_time_direction(-1)
	if _is_paused():
		resume()
	if _get_on_rewind() != null:
		_get_on_rewind().call_func()


func is_playing() -> bool:
	return _get_playing() and not _is_finished() == true


func is_finished() -> bool:
	return _is_finished()


func is_paused() -> bool:
	return _get_paused()


func is_infinity_loop() -> bool:
	return get_loop_count() == -1.0


func has_loops() -> bool:
	return get_loop_count() > 0 and not is_infinity_loop() == true


func get_loop_count() -> int:
	return _get_loop_count()


func in_sequence() -> void:
	_set_sequence(true)
	

func on_started(func_ref: FuncRef):
	_set_on_started(func_ref)
	return self


func on_step(func_ref: FuncRef):
	_set_on_step(func_ref)
	return self


func on_finished(func_ref: FuncRef):
	_set_on_finished(func_ref)
	return self


func on_loop_finished(func_ref: FuncRef):
	_set_on_loop_finished(func_ref)
	return self


func on_infinity_loop_finished(func_ref: FuncRef):
	_set_on_infinity_loop_finished(func_ref)
	return self


func on_delay_finished(func_ref: FuncRef):
	_set_on_delay_finished(func_ref)
	return self


func on_rewind(func_ref: FuncRef):
	_set_on_rewind(func_ref)
	return self


func on_paused(func_ref: FuncRef):
	_set_on_paused(func_ref)
	return self


func on_flip(func_ref: FuncRef):
	_set_on_flip(func_ref)
	return self


func on_running(func_ref: FuncRef):
	_set_on_running(func_ref)
	return self


func get_duration() -> float:
	return _get_duration()


func _handle_started() -> void:
	if not  _is_started() == true:
		if _get_on_started() != null:
			_get_on_started().call_func()
		_set_started(true)
		_set_playing(true)
		_set_paused(false)
		emit_signal("animation_started")


func _handle_loops() -> void:
	if _get_loop_count() > 0:
		_set_loop_count(_get_loop_count() - 1)
		reset()
		if _get_on_loop_finished() != null:
			_get_on_loop_finished().call_funcv([_get_loop_count()])
		emit_signal("animation_loop_finished", _get_loop_count())
	
	elif _get_loop_count() == -1.0:
		reset()
		if _get_on_infinity_loop_finished() != null:
			_get_on_infinity_loop_finished().call_funcv([_get_loop_count()])
		emit_signal("animation_infinity_loop_finished", _get_loop_count())
	_check_loop_type()


func _handle_loop_type() -> void:
	pass


func _check_loop_type() -> void:
	pass


func _handle_finished() -> void:
	if _is_animation_finished() == true:
		_set_finished(true)
		_set_playing(false)
		if _get_loop_count() != 0:
			_handle_loops()
		if _get_on_finished() != null and _get_on_finished().is_valid() == true:
			_get_on_finished().call_func()
		if _get_on_finished() != null and _get_on_finished().is_valid() == false and _get_on_finished().has_method(_get_on_finished().get_function()) == false:
			push_error("Is invalid funcref %s" % _get_on_finished())
		emit_signal("animation_finished")


func _is_animation_process() -> bool:
	return _get_elapsed_time() <=_get_duration() or _get_loop_count() > 0


func _is_animation_finished() -> bool:
	return _get_elapsed_time() == _get_duration()


func _set_target(value: Object):
	_target = value
	return self
	

func _get_target() -> Object:
	return _target


func _set_elapsed_time(value: float) -> void:
	_elapsed_time = value
	_elapsed_time = clamp(_get_elapsed_time(), EmptyTime, _get_duration())
	

func _get_elapsed_time() -> float:
	return _elapsed_time


func _set_duration(value: float) -> void:
	_duration = value
	

func _get_duration() -> float:
	return _duration


func _get_time_normalized() -> float:
	return _get_elapsed_time() / _get_duration()


func _set_delay(value: float) -> void:
	_delay = value
	_delay = max(EmptyTime, _get_delay())
	

func _get_delay() -> float:
	return _delay


func _has_delay() -> bool:
	return _get_delay() > 0


func _is_delay_finished() -> bool:
	return _get_delay() == EmptyTime


func _set_initial_delay(value: float) -> void:
	_initial_delay = value
	

func _get_initial_delay() -> float:
	return _initial_delay
	

func _set_speed_scale(value: float) -> void:
	_speed_scale = value
	

func _get_speed_scale() -> float:
	return _speed_scale


func _set_time_direction(value: float) -> void:
	_time_direction = value
	

func _get_time_direction() -> float:
	return _time_direction


func _set_started(value: bool) -> void:
	_started = value
	

func _get_started() -> bool:
	return _started


func _is_started() -> bool:
	return _get_started()


func _set_playing(value: bool) -> void:
	_playing = value
	

func _get_playing() -> bool:
	return _playing


func _set_paused(value: bool) -> void:
	_paused = value
	

func _get_paused() -> bool:
	return _paused


func _is_paused() -> bool:
	return _get_paused()


func _set_finished(value: bool) -> void:
	_finished = value
	

func _get_finished() -> bool:
	return _finished


func _is_finished() -> bool:
	return _get_finished()


func _set_sequence(value: bool) -> void:
	_sequence = value
	

func _get_sequence() -> bool:
	return _sequence


func _is_sequence() -> bool:
	return _get_sequence()
	

func _set_loop_count(value: int) -> void:
	_loop_count = value
	

func _get_loop_count() -> int:
	return _loop_count
	
	
func _set_loop_type(value: String) -> void:
	_loop_type = value
	

func _get_loop_type() -> String:
	return _loop_type


func _set_ease(value) -> void:
	_ease = value


func _get_ease():
	return _ease
	

func _set_id(value) -> void:
	_id = value


func _get_id():
	return _id


func _set_on_started(value: FuncRef) -> void:
	_on_started = value


func _get_on_started() -> FuncRef:
	return _on_started


func _set_on_step(value: FuncRef) -> void:
	_on_step = value


func _get_on_step() -> FuncRef:
	return _on_step


func _set_on_running(value: FuncRef) -> void:
	_on_running = value


func _get_on_running() -> FuncRef:
	return _on_running


func _set_on_finished(value: FuncRef) -> void:
	_on_finished = value


func _get_on_finished() -> FuncRef:
	return _on_finished


func _set_on_loop_finished(value: FuncRef) -> void:
	_on_loop_finished = value


func _get_on_loop_finished() -> FuncRef:
	return _on_loop_finished


func _set_on_infinity_loop_finished(value: FuncRef) -> void:
	_on_infinity_loop_finished = value


func _get_on_infinity_loop_finished() -> FuncRef:
	return _on_infinity_loop_finished


func _set_on_delay_finished(value: FuncRef) -> void:
	_on_delay_finished = value


func _get_on_delay_finished() -> FuncRef:
	return _on_delay_finished
	

func _set_on_rewind(value: FuncRef) -> void:
	_on_rewind = value


func _get_on_rewind() -> FuncRef:
	return _on_rewind


func _set_on_paused(value: FuncRef) -> void:
	_on_paused = value


func _get_on_paused() -> FuncRef:
	return _on_paused


func _set_on_flip(value: FuncRef) -> void:
	_on_flip = value


func _get_on_flip() -> FuncRef:
	return _on_flip
