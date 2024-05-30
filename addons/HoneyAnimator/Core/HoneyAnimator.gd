extends Node

const Constants := preload("res://addons/HoneyAnimator/Core/HoneyConstants.gd")
const _EasingData := Constants.EasingData

const LoopType := {"Restart":"Restart","Yoyo":"Yoyo"}
const TimeDirection := {"Left":-1.0,"Right":1.0}
const Ease := Constants.EasingsData.EasingNames

const EmptyTime := 0.0
const SpeedScaleDefault := 1.0


func create_honey_animator() -> HoneyAnimatorSystem:
	return HoneyAnimatorSystem.new(self)


func create_sequence() -> HoneySequence:
	return HoneySequence.new(self)


func create_parameters() -> HoneyParameter:
	return HoneyParameter.new()


class HoneyAnimatorSystem:
	const HONEY_ANIMATOR_NAME := "HoneyAnimator"
	
	var _node : Node = null setget _set_node,_get_node
	var _tree := Engine.get_main_loop() as SceneTree setget _set_tree,_get_tree
	
	var _animations := [] setget _set_animations,_get_animations
	
	var _running := false
	var _paused := false setget _set_paused,_get_paused
	var _auto_start := true setget _set_auto_start,_get_auto_start
	
	
	func _init(node: Node) -> void:
		if not _get_tree().has_meta(HONEY_ANIMATOR_NAME):
			_get_tree().set_meta(HONEY_ANIMATOR_NAME, [])
		_set_node(node)
		_get_tree().get_meta(HONEY_ANIMATOR_NAME).append(self)
		_get_tree().connect("idle_frame", self, "_update")
	

	func target_node(node: Node) -> HoneyMethodsPropertys:
		var animation_methods := HoneyMethodsPropertys.new(self, node)
		return animation_methods
	
	
	func _update() -> void:
		var delta := _node.get_process_delta_time()
		if is_auto_start() == true:
			if _running == false:
				_running = true
			_process_animations(delta)
	
	
	func _process_animations(delta: float) -> void:
		for animation in _get_animations():
			animation.play()
			if animation.is_playing() == true:
				animation.process_animation(delta)


	func _set_node(value: Node) -> void:
		_node = value
	
	
	func _get_node() -> Node:
		return _node


	func _set_tree(value: SceneTree) -> void:
		_tree = value
	
	
	func _get_tree() -> SceneTree:
		return _tree


	func _set_animations(value: Array) -> void:
		_animations = value
	
	
	func _get_animations() -> Array:
		return _animations


	func _set_paused(value: bool) -> void:
		_paused = value
	
	
	func _get_paused() -> bool:
		return _paused
		
	
	func _set_auto_start(value: bool) -> void:
		_auto_start = value
	
	
	func _get_auto_start() -> bool:
		return _auto_start
	
	
	func _set_running(value: bool) -> void:
		_running = value
	
	
	func _get_running() -> bool:
		return _running
	
	
	func is_running() -> bool:
		return _get_running()
	
	
	func flip_all() -> void:
		for animation in _animations:
			animation.flip()


	func flip(id) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.flip()


	func play_all() -> void:
		for animation in _animations:
			animation.play()


	func play(id) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.play()


	func play_backwards_all() -> void:
		for animation in _animations:
			animation.play_backwards()


	func play_backwards(id) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.play_backwards()


	func play_forward_all() -> void:
		for animation in _animations:
			animation.play_forward()


	func play_forward(id: int) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.play_forward()


	func restart_all(include_delay: bool = true, change_delay_to: float = -1.0) -> void:
		for animation in _animations:
			animation.restart(include_delay, change_delay_to)


	func restart(id: int, include_delay: bool = true, change_delay_to: float = -1.0) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.restart(include_delay, change_delay_to)


	func rewind_all(include_delay: bool = true) -> void:
		for animation in _animations:
			animation.rewind(include_delay)


	func rewind(id: int, include_delay: bool = true) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.rewind(include_delay)
	
	
	func kill() -> void:
		restart_all(false)
		
	
	func set_auto_start(value: bool) -> void:
		_set_auto_start(value)
	
	
	func is_paused() -> bool:
		return _get_paused()
	
	
	func is_auto_start() -> bool:
		return _get_auto_start()
	
	
	func get_animations() -> Array:
		return _get_animations()
	
	
	func get_paused_animations() -> Array:
		var paused_animations := []
		for animation in _animations:
			if animation.is_paused() == true:
				paused_animations.append(animation)
		return paused_animations
	
	
	func get_running_animations() -> Array:
		var running_animations := []
		for animation in _animations:
			if animation.is_running() == true:
				running_animations.append(animation)
		return running_animations
	
	
	func get_animations_by_id(id) -> Array:
		var animations_id := []
		for animation in _animations:
			if animation.get_id() == id:
				animations_id.append(animation)
		return animations_id
	
	
	func get_total_animations_by_id() -> int:
		var index := 0
		for animation in _animations:
			if animation.get_id() != null:
				index += 1
		return index
	
	
	func get_total_animations_loops() -> int:
		var index := 0
		for animation in _animations:
			if animation.has_loops() == true:
				index += 1
		return index


class HoneyMethodsPropertys:
	
	var _honey_animator : Object
	var _node : Node
	
	
	func _init(honey_animator: Object,node: Node) -> void:
		_honey_animator = honey_animator
		_node = node
	
	
	func squash_to_2d(squash_amount: float,scale_base,duration: float) -> HoneyProperty:
		if _node is Node2D or Control:
			return scale_to(scale_base, duration).from(Vector2(1+ squash_amount,1- squash_amount))
		else:
			return scale_to(scale_base, duration).from(Vector3(1+ squash_amount,1- squash_amount,1- squash_amount))
	
	
	func stretch_to_2d(stretch_amount: float,scale_base,duration: float) -> HoneyProperty:
		if _node is Node2D or Control:
			return scale_to(scale_base, duration).from(Vector2(1- stretch_amount,1+ stretch_amount))
		else:
			return scale_to(scale_base, duration).from(Vector3(1- stretch_amount,1+ stretch_amount,1- stretch_amount))
	
	
	func fade_in(duration: float) -> HoneyProperty:
		return color_to(Color.white, duration).from(Color.transparent)
	
	
	func fade_out(duration: float) -> HoneyProperty:
		return color_to(Color.transparent, duration).from(Color.white)
	
	
	func color_to(to_value: Color,duration: float) -> HoneyProperty:
		return anima_property("modulate", to_value, duration)
	
	
	func local_color_to(to_value: Color,duration: float) -> HoneyProperty:
		return anima_property("self_modulate", to_value, duration)
	
	
	func rotation_to(to_value,duration: float) -> HoneyProperty:
		var property_rotation := Constants.get_rotation_property(_node)
		return anima_property(property_rotation, to_value, duration)
	
	
	func rotation_degrees_to(to_value,duration: float) -> HoneyProperty:
		var property_rotation_degrees := Constants.get_rotation_degrees_property(_node)
		return anima_property(property_rotation_degrees, to_value, duration)
	
	
	func move_to(to_value,duration: float) -> HoneyProperty:
		var property_position := Constants.get_position_property(_node)
		return anima_property(property_position, to_value, duration)
	
	
	func move_x_to(to_value,duration: float) -> HoneyProperty:
		var property_position := Constants.get_position_property(_node, "x")
		return anima_property(property_position, to_value, duration)
	
	
	func move_y_to(to_value,duration: float) -> HoneyProperty:
		var property_position := Constants.get_position_property(_node, "y")
		return anima_property(property_position, to_value, duration)
	
	
	func move_z_to(to_value,duration: float) -> HoneyProperty:
		var property_position := Constants.get_position_property(_node, "z")
		return anima_property(property_position, to_value, duration)
	
	
	func scale_to(to_value,duration: float) -> HoneyProperty:
		var property_scale := Constants.get_scale_property(_node)
		return anima_property(property_scale, to_value, duration)
	
	
	func scale_x_to(to_value,duration: float) -> HoneyProperty:
		var property_scale := Constants.get_scale_property(_node, "x")
		return anima_property(property_scale, to_value, duration)
	
	
	func scale_y_to(to_value,duration: float) -> HoneyProperty:
		var property_scale := Constants.get_scale_property(_node, "y")
		return anima_property(property_scale, to_value, duration)
	
	
	func scale_z_to(to_value,duration: float) -> HoneyProperty:
		var property_scale := Constants.get_scale_property(_node, "z")
		return anima_property(property_scale, to_value, duration)
	
	
	func size_to(to_value,duration: float) -> HoneyProperty:
		var property_scale := Constants.get_size_property(_node)
		return anima_property(property_scale, to_value, duration)
	
	
	func size_x_to(to_value,duration: float) -> HoneyProperty:
		var property_scale := Constants.get_size_property(_node, "x")
		return anima_property(property_scale, to_value, duration)
	
	
	func size_y_to(to_value,duration: float) -> HoneyProperty:
		var property_scale := Constants.get_size_property(_node, "y")
		return anima_property(property_scale, to_value, duration)
	
	
	func size_z_to(to_value,duration: float) -> HoneyProperty:
		var property_scale := Constants.get_size_property(_node, "z")
		return anima_property(property_scale, to_value, duration)
	
	
	func local_move_to(to_value,duration: float) -> HoneyProperty:
		var property_position := Constants.get_local_position_property(_node)
		return anima_property(property_position, to_value, duration)
	
	
	func local_move_to_x(to_value,duration: float) -> HoneyProperty:
		var property_position := Constants.get_local_position_property(_node, "x")
		return anima_property(property_position, to_value, duration)
	
	
	func local_move_to_y(to_value,duration: float) -> HoneyProperty:
		var property_position := Constants.get_local_position_property(_node, "y")
		return anima_property(property_position, to_value, duration)
	
	
	func local_move_to_z(to_value,duration: float) -> HoneyProperty:
		var property_position := Constants.get_local_position_property(_node, "z")
		return anima_property(property_position, to_value, duration)
	
	
	func rect_to(to_value: Rect2,duration: float) -> HoneyProperty:
		return anima_property("region_rect", to_value, duration)
	
	
	func anima_property(property: NodePath,to_value,duration: float) -> HoneyProperty:
		if _node.get_indexed(property) == null:
			push_error("Node %s dont has this property %s" % [_node,property])
			return null
		var animation_property := HoneyProperty.new(_node)
		_honey_animator.get_animations().append(animation_property)
		return animation_property.anima_property(property, to_value, duration)
	
	
	func anima_method(method: FuncRef, from, to_value,duration: float) -> HoneyMethod:
		var animation_method := HoneyMethod.new(_node)
		_honey_animator.get_animations().append(animation_method)
		return animation_method.anima_method(method, from, to_value, duration)


class HoneyParameter:
	signal animation_started()
	signal animation_step(value)
	signal animation_finished()
	signal animation_loop_finished(loop_count)
	signal animation_infinity_loop_finished(loop_count)
	signal animation_delay_finished()
	signal animation_rewind()
	signal animation_paused()
	signal animation_flip()
	
	var _ease = null setget _set_ease,_get_ease
	var _id setget _set_id,_get_id

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


class HoneyAnimation extends HoneyParameter:
	
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
			_set_ease(Ease.EaseLinearInOut)
		
		elif _get_ease() is Curve:
			time_normalized = _get_ease().interpolate(_get_time_normalized())
		
		elif _get_ease() is String:
			var easings := _get_ease().split("_") as PoolStringArray
			var easing_name := "ease_%s" % easings[1]
			if easings.size() == 3:
				var ease_data := _EasingData[easing_name] as Resource
				var ease_type := "ease_%s" % easings[2]
				time_normalized = funcref(ease_data, ease_type).call_func(_get_time_normalized())
			
			elif easings.size() == 4:
				var ease_data := _EasingData[easing_name] as Resource
				var ease_type := "ease_%s_%s" % [easings[2],easings[3]]
				time_normalized = funcref(ease_data, ease_type).call_func(_get_time_normalized())
		
		elif _get_ease() is FuncRef:
			time_normalized = _get_ease().call_func(_get_time_normalized()) as float
		return time_normalized
	

class HoneyProperty extends HoneyAnimation:
	
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


class HoneyMethod extends HoneyAnimation:
	
	var _method : FuncRef = null setget _set_method,_get_method
	var _from setget _set_from,_get_from
	var _to setget _set_to,_get_to
	var _is_from := true setget _set_is_from,_get_is_from
	var _as_relative := false setget _set_to,_get_to
	
	
	func _init(from) -> void:
		_set_from(from)
		connect("animation_finished", self, "_on_finished")
	
	
	func anima_method(method: FuncRef,from,to_value,duration: float) -> HoneyMethod:
		_set_method(method)
		_set_from(from)
		_set_to(to_value)
		_set_duration(duration)
		return self
	
	
	func _animation_step() -> void:
		var time_normalized := _check_ease(_get_time_normalized()) as float
		var animation_value = _get_from() + (_get_to() - _get_from()) * time_normalized * _get_time_direction()
		if _get_on_step() != null:
			_get_on_step().call_funcv([animation_value])
		if _get_method().is_valid() == true:
			_get_method().call_func(animation_value)
		else:
			_get_target().call(_get_method().function, animation_value)
		emit_signal("animation_step", animation_value)


	func _check_loop_type() -> void:
		if _get_loop_type() == LoopType.Restart:
			_get_method().call_func(_get_from())
		elif _get_loop_type() == LoopType.Yoyo:
			var old_from = _get_from()
			var old_to = _get_to()
			_set_to(old_from)
			_set_from(old_to)
			_get_method().call_func(_get_from())
	
	
	func on_started(func_ref: FuncRef) -> HoneyMethod:
		_set_on_started(func_ref)
		return self
	
	
	func on_step(func_ref: FuncRef) -> HoneyMethod:
		_set_on_step(func_ref)
		return self
	
	
	func on_running(func_ref: FuncRef) -> HoneyMethod:
		_set_on_running(func_ref)
		return self
	
	
	func on_finished(func_ref: FuncRef) -> HoneyMethod:
		_set_on_finished(func_ref)
		return self
	

	func on_loop_finished(func_ref: FuncRef) -> HoneyMethod:
		_set_on_loop_finished(func_ref)
		return self
	
	
	func on_infinity_loop_finished(func_ref: FuncRef) -> HoneyMethod:
		_set_on_infinity_loop_finished(func_ref)
		return self
	
	
	func on_delay_finished(func_ref: FuncRef) -> HoneyMethod:
		_set_on_delay_finished(func_ref)
		return self
	
	
	func on_rewind(func_ref: FuncRef) -> HoneyMethod:
		_set_on_rewind(func_ref)
		return self
	
	
	func on_paused(func_ref: FuncRef) -> HoneyMethod:
		_set_on_paused(func_ref)
		return self
	
	
	func on_flip(func_ref: FuncRef) -> HoneyMethod:
		_set_on_flip(func_ref)
		return self
	
	
	func update_from() -> HoneyMethod:
		return self
	
	
	func play() -> HoneyMethod:
		_handle_started()
		return self
	
	
	func set_speed_scale(value: float) -> HoneyMethod:
		_set_speed_scale(value)
		return self


	func set_delay(value: float) -> HoneyMethod:
		_set_delay(value)
		_set_initial_delay(value)
		return self
	
	
	func set_loops(value: int,loop_type: String = LoopType.Restart) -> HoneyMethod:
		_set_loop_count(value)
		_set_loop_type(loop_type)
		return self
		
		
	func paused() -> HoneyMethod:
		_set_paused(true)
		emit_signal("animation_paused")
		return self


	func resume() -> HoneyMethod:
		_set_paused(false)
		return self
	
	
	func reset() -> HoneyMethod:
		_set_started(false)
		_set_playing(false)
		_set_finished(false)
		_set_paused(false)
		_set_elapsed_time(EmptyTime)
		_handle_loop_type()
		_set_delay(_get_initial_delay())
		return self
	
	
	func set_ease(value) -> HoneyMethod:
		_set_ease(value)
		return self
	
	
	func _set_target(value: Object) -> HoneyMethod:
		_target = value
		return self
		
	
	func _set_method(value: FuncRef) -> void:
		_method = value
	
	
	func _get_method() -> FuncRef:
		return _method
	
	
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


class HoneyIntervalAnimation extends HoneyAnimation:
	
	
	func _init(duration: float) -> void:
		_set_duration(duration)


class HoneyFuncRefAnimation extends HoneyAnimation:
	
	var _func_ref : FuncRef = null setget _set_func_ref,_get_func_ref
	var _args := [] setget _set_args,_get_args
	
	
	func _init(func_ref: FuncRef,args: Array) -> void:
		_set_func_ref(func_ref)
		_set_args(args)
		_set_duration(EmptyTime)
		connect("animation_started", self, "_on_animation_started")
	
	
	func _on_animation_started() -> void:
		if _get_func_ref() != null:
			if _get_args().empty() == true:
				_get_func_ref().call_func()
			else:
				_get_func_ref().call_funcv(_get_args())
		emit_signal("animation_finished")

	
	func _set_func_ref(value: FuncRef) -> void:
		_func_ref = value

	
	func _get_func_ref() -> FuncRef:
		return _func_ref
	
	
	func _set_args(value: Array) -> void:
		_args = value

	
	func _get_args() -> Array:
		return _args


class HoneySequence:
	signal sequence_started()
	signal sequence_step_finished(idx)
	signal sequence_all_finished()
	
	const HONEY_ANIMATOR_NAME := "HoneyAnimator"
	
	var _node : Node = null setget _set_node,_get_node
	var _tree := Engine.get_main_loop() as SceneTree setget _set_tree,_get_tree
	var _current_index := 0 setget _set_current_index,_get_current_index
	var _animations := [] setget _set_animations,_get_animations
	var _all_completed := false setget _set_all_completed,_get_all_completed
	var _speed_scale := 1.0 setget _set_speed_scale,_get_speed_scale
	
	var _started := false setget _set_started,_get_started
	var _paused := false setget _set_paused,_get_paused
	var _auto_start := true setget _set_auto_start,_get_auto_start
	var _running := false setget _set_running,_get_running
	
	var _on_step_finished : FuncRef = null setget _set_on_step_finished,_get_on_step_finished
	var _on_all_finished : FuncRef = null setget _set_on_all_finished,_get_on_all_finished
	
	
	func _init(node: Node) -> void:
		if not _get_tree().has_meta(HONEY_ANIMATOR_NAME):
			_get_tree().set_meta(HONEY_ANIMATOR_NAME, [])
		_set_node(node)
		_get_tree().get_meta(HONEY_ANIMATOR_NAME).append(self)
		_get_tree().connect("idle_frame", self, "_update")
	
	
	func _update() -> void:
		var delta := _node.get_process_delta_time()
		if is_auto_start() == true:
			if _get_started() == false:
				_set_started(true)
				emit_signal("sequence_started")
			if _running == false:
				_set_running(true)
			_process_sequence(delta)
	
	
	func on_step_finished(value: FuncRef) -> void:
		_set_on_step_finished(value)
	
	
	func on_all_finished(value: FuncRef) -> void:
		_set_on_all_finished(value)
	
	
	func append(animation: HoneyParameter) -> HoneySequence:
		_animations.append(animation)
		animation.in_sequence()
		animation.connect("animation_finished", self, "_prepare_next")
		return self
	
	
	func append_callback(target: Object,args: Array = [])  -> HoneySequence:
		var func_ref_animation := HoneyFuncRefAnimation.new(target, args)
		_animations.append(func_ref_animation)
		func_ref_animation.connect("animation_finished", self, "_prepare_next")
		return self
	
	
	func append_interval(duration: float) -> HoneySequence:
		var interval_animation := HoneyIntervalAnimation.new(duration)
		_animations.append(interval_animation)
		interval_animation.in_sequence()
		interval_animation.connect("animation_finished", self, "_prepare_next")
		return self
	
	
	func _prepare_next() -> void:
			emit_signal("sequence_step_finished", _current_index)
		
			if _get_on_step_finished() != null:
				_get_on_step_finished().call_funcv([_current_index])
			
			if _has_loops() == true:
				return
			if _current_index < _animations.size() -1:
				_current_index += 1
			if _current_index < _animations.size() and _animations[_current_index].has_method("update_from"):
				_animations[_current_index].update_from()
	
	
	func _process_sequence(delta: float) -> void:
		if _current_index < _animations.size():
			if _get_animation().is_finished() == false:
				_get_animation().play()
				_get_animation().process_animation(delta * _get_speed_scale(), true)
		
		if _is_all_completed() == true:
			_set_all_completed(true)
			emit_signal("sequence_all_finished")
			if _get_on_all_finished() != null:
				_get_on_all_finished().call_func()
	
	
	func _has_loops() -> bool:
		return _get_animation().has_loops() == true or _get_animation().is_infinity_loop() == true
	
	
	func _is_all_completed() -> bool:
		return _current_index == _animations.size() and not _get_all_completed() == true
	
	
	func _get_animation() -> Object:
		return _get_animations()[_current_index]
	
	
	func is_auto_start() -> bool:
		return _get_auto_start()
	
	
	func is_playing() -> bool:
		return _current_index != _animations.size()
	
	
	func is_completed() -> bool:
		return _all_completed == true
	
	
	func flip_all() -> void:
		for animation in _animations:
			animation.flip()


	func flip(id) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.flip()


	func play_all() -> void:
		for animation in _animations:
			animation.play()


	func play(id) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.play()


	func play_backwards_all() -> void:
		for animation in _animations:
			animation.play_backwards()


	func play_backwards(id) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.play_backwards()


	func play_forward_all() -> void:
		for animation in _animations:
			animation.play_forward()


	func play_forward(id: int) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.play_forward()


	func restart_all(include_delay: bool = true, change_delay_to: float = -1.0) -> void:
		for animation in _animations:
			animation.restart(include_delay, change_delay_to)


	func restart(id: int, include_delay: bool = true, change_delay_to: float = -1.0) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.restart(include_delay, change_delay_to)


	func rewind_all(include_delay: bool = true) -> void:
		for animation in _animations:
			animation.rewind(include_delay)


	func rewind(id: int, include_delay: bool = true) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.rewind(include_delay)
	
	
	func kill() -> void:
		restart_all(false)
	
	
	func set_speed_scale(value: float) -> void:
		_set_speed_scale(value)
		
		
	func get_speed_scale() -> float:
		return _get_speed_scale()
	
	
	func _set_speed_scale(value: float) -> void:
		_speed_scale = value
		
		
	func _get_speed_scale() -> float:
		return _speed_scale
	
	
	func _set_current_index(value: int) -> void:
		_current_index = value
	
	
	func _get_current_index() -> int:
		return _current_index
	
	
	func _set_all_completed(value: bool) -> void:
		_all_completed = value
	
	
	func _get_all_completed() -> bool:
		return _all_completed
	
	
	func _set_node(value: Node) -> void:
		_node = value
	
	
	func _get_node() -> Node:
		return _node


	func _set_tree(value: SceneTree) -> void:
		_tree = value
	
	
	func _get_tree() -> SceneTree:
		return _tree


	func _set_paused(value: bool) -> void:
		_paused = value
	
	
	func _get_paused() -> bool:
		return _paused
		
	
	func _set_auto_start(value: bool) -> void:
		_auto_start = value
	
	
	func _get_auto_start() -> bool:
		return _auto_start
	
	
	func _set_running(value: bool) -> void:
		_running = value
	
	
	func _get_running() -> bool:
		return _running
	
	
	func is_running() -> bool:
		return _get_running()


	func _set_animations(value: Array) -> void:
		_animations = value
	
	
	func _get_animations() -> Array:
		return _animations
	
	
	func _set_on_step_finished(value: FuncRef) -> void:
		_on_step_finished = value
	
	
	func _get_on_step_finished() -> FuncRef:
		return _on_step_finished
	
	
	func _set_on_all_finished(value: FuncRef) -> void:
		_on_all_finished = value
	
	
	func _get_on_all_finished() -> FuncRef:
		return _on_all_finished
	
	
	func _set_started(value: bool) -> void:
		_started = value
		

	func _get_started() -> bool:
		return _started
	
	
	func _is_started() -> bool:
		return _get_started()
