extends Node

const _HoneyConstants := preload("res://addons/HoneyAnimator/Core/HoneyConstants.gd")

const Ease := preload("res://addons/HoneyAnimator/Core/EasingData.tres").data.EasingNames


func create_honey_animator() -> HoneyAnimatorSystem:
	return HoneyAnimatorSystem.new(self)


func create_sequence() -> HoneySequence:
	return HoneySequence.new(self)


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
	

	func target_node(node: Node) -> HoneyDeclarationNode:
		var animation_methods := HoneyDeclarationNode.new(self, node)
		return animation_methods
	
	
	func target_float(from: float,to: float,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)
	
	
	func target_vector2(from: Vector2,to: Vector2,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)
	
	
	func target_vector3(from: Vector3,to: Vector3,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)
	
	
	func target_int(from: int,to: int,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)


	func target_rect2(from: Rect2,to: Rect2,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)
	
	
	func target_color(from: Color,to: Color,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)
	
	
	func target_transform3d(from: Transform,to: Transform,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)
	
	
	func target_aabb(from: AABB,to: AABB,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)
	
	
	func target_quad(from: Quat,to: Quat,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)
	
	
	func target_basis(from: Quat,to: Quat,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)
	
	
	func target_transform2d(from: Transform2D,to: Transform2D,duration: float) -> HoneyMethod:
		return _target_virtual(from, to, duration)
	
	
	func _target_virtual(from,to,duration: float) -> HoneyMethod:
		var honey_method := HoneyMethod.new(from).anima_method(funcref(self, "_anima_virtual"), from, to, duration)
		return honey_method
	
	
	func _anima_virtual(value) -> void:
		pass
	
	
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


	func play_all_backwards() -> void:
		for animation in _animations:
			animation.play_backwards()


	func play_backwards(id) -> void:
		for animation in _animations:
			if animation.get_id() == id:
				animation.play_backwards()


	func play_all_forward() -> void:
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


class HoneySequence:
	signal sequence_started()
	signal sequence_running()
	signal sequence_step_finished(idx)
	signal sequence_all_finished()

	const HONEY_ANIMATOR_NAME := "HoneyAnimator"
	const START_INDEX := 0

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
	
	var _on_started : FuncRef = null setget _set_on_started,_get_on_started
	var _on_running : FuncRef = null setget _set_on_running,_get_on_running
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
				
				if _get_on_started() != null:
					_get_on_started().call_func()
				
			if _running == false:
				_set_running(true)
			_process_sequence(delta)


	func on_started(value: FuncRef) -> void:
		_set_on_started(value)


	func on_step_finished(value: FuncRef) -> void:
		_set_on_step_finished(value)


	func on_all_finished(value: FuncRef) -> void:
		_set_on_all_finished(value)


	func append(animation: HoneyParameters) -> HoneySequence:
		_animations.append({"animations":[animation]})
		animation.in_sequence()
		animation.connect("animation_finished", self, "_prepare_next")
		return self


	func append_callback(target: Object,args: Array = [])  -> HoneySequence:
		var func_ref_animation := HoneyFuncRef.new(target, args)
		return append(func_ref_animation)


	func append_interval(duration: float) -> HoneySequence:
		var interval_animation := HoneyInterval.new(duration)
		return append(interval_animation)


	func join(animation: HoneyAnimation) -> HoneySequence:
		_animations[_animations.size() - 1]["animations"].append(animation)
		animation.in_sequence()
		animation.connect("animation_finished", self, "_prepare_next")
		return self


	func insert(at_position: int,animation: HoneyAnimation) -> HoneySequence:
		_animations[at_position]["animations"].insert(at_position, animation)
		animation.in_sequence()
		animation.connect("animation_finished", self, "_prepare_next")
		return self
	
	
	func insert_callback(at_position: int,animation: HoneyFuncRef) -> HoneySequence:
		_animations[at_position]["animations"].insert(at_position, animation)
		animation.in_sequence()
		animation.connect("animation_finished", self, "_prepare_next")
		return self
	
	
	func prepend(animation: HoneyFuncRef) -> HoneySequence:
		_animations[START_INDEX]["animations"].insert(START_INDEX, animation)
		animation.in_sequence()
		animation.connect("animation_finished", self, "_prepare_next")
		return self
	
	
	func prepend_interval(animation: HoneyInterval) -> HoneySequence:
		_animations[START_INDEX]["animations"].insert(START_INDEX, animation)
		animation.in_sequence()
		animation.connect("animation_finished", self, "_prepare_next")
		return self
	
	
	func prepend_callback(animation: HoneyFuncRef) -> HoneySequence:
		_animations[0]["animations"].insert(0, animation)
		animation.in_sequence()
		animation.connect("animation_finished", self, "_prepare_next")
		return self


	func _prepare_next() -> void:
		emit_signal("sequence_step_finished", _current_index)

		if _get_on_step_finished() != null:
			_get_on_step_finished().call_funcv([_current_index])
		
		if _has_loops() == true:
			return
		if _current_index < _animations.size() -1:
			_current_index += 1
		
		if _current_index < _animations.size():
			var current_animations := _animations[_current_index]["animations"] as Array
			if current_animations.size() > 1:
				for animation in current_animations:
					if animation.has_method("update_from"):
						animation.update_from()
			
			elif current_animations.size() == 1:
				var animation := current_animations[0] as HoneyParameters
				if animation.has_method("update_from"):
						animation.update_from()


	func _process_sequence(delta: float) -> void:
		if _current_index < _animations.size():
			var current_animations := _animations[_current_index]["animations"] as Array
			if current_animations.size() > 1:
				for animation in current_animations:
					if animation.is_finished() == false:
						animation.play()
						animation.process_animation(delta * _get_speed_scale(), true)
			
			elif current_animations.size() == 1:
				var animation := current_animations[0] as HoneyParameters
				if animation.is_finished() == false:
					animation.play()
					animation.process_animation(delta * _get_speed_scale(), true)
			
			if _get_on_running() != null:
				_get_on_running().call_func()
			
			emit_signal("sequence_running")
		
		if _is_all_completed() == true:
			_completed_sequence()


	func _completed_sequence() -> void:
		_set_all_completed(true)
		emit_signal("sequence_all_finished")
		if _get_on_all_finished() != null:
			_get_on_all_finished().call_func()


	func _has_loops() -> bool:
		var has_loops := false
		var current_animations := _animations[_current_index]["animations"] as Array
		for animation in current_animations:
			if animation.has_loops() == true or animation.is_infinity_loop() == true:
				has_loops = true
		return has_loops


	func _is_all_completed() -> bool:
		return _current_index >= _animations.size()


	func is_auto_start() -> bool:
		return _get_auto_start()


	func is_playing() -> bool:
		return _current_index < _animations.size()


	func is_completed() -> bool:
		return _all_completed == true


	func flip_all() -> void:
		for animation in _animations:
			animation.flip()


	func flip(id) -> void:
		for anima_dict in _animations:
			if anima_dict["animation"].get_id() == id:
				anima_dict["animation"].flip()


	func play_all() -> void:
		for anima_dict in _animations:
			anima_dict["animation"].play()


	func play(id) -> void:
		for anima_dict in _animations:
			if anima_dict["animation"].get_id() == id:
				anima_dict["animation"].play()


	func play_backwards_all() -> void:
		for anima_dict in _animations:
			anima_dict["animation"].play_backwards()


	func play_backwards(id) -> void:
		for anima_dict in _animations:
			if anima_dict["animation"].get_id() == id:
				anima_dict["animation"].play_backwards()


	func play_forward_all() -> void:
		for anima_dict in _animations:
			anima_dict["animation"].play_forward()


	func play_forward(id: int) -> void:
		for anima_dict in _animations:
			if anima_dict["animation"].get_id() == id:
				anima_dict["animation"].play_forward()


	func restart_all(include_delay: bool = true, change_delay_to: float = -1.0) -> void:
		for anima_dict in _animations:
			anima_dict["animation"].restart(include_delay, change_delay_to)


	func restart(id: int, include_delay: bool = true, change_delay_to: float = -1.0) -> void:
		for anima_dict in _animations:
			if anima_dict["animation"].get_id() == id:
				anima_dict["animation"].restart(include_delay, change_delay_to)


	func rewind_all(include_delay: bool = true) -> void:
		for anima_dict in _animations:
			anima_dict["animation"].rewind(include_delay)


	func rewind(id: int, include_delay: bool = true) -> void:
		for anima_dict in _animations:
			if anima_dict["animation"].get_id() == id:
				anima_dict["animation"].rewind(include_delay)



	func reset() -> void:
		kill()
		_current_index = 0


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


	func _set_on_started(value: FuncRef) -> void:
		_on_started = value


	func _get_on_started() -> FuncRef:
		return _on_started


	func _set_on_running(value: FuncRef) -> void:
		_on_running = value


	func _get_on_running() -> FuncRef:
		return _on_running


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
