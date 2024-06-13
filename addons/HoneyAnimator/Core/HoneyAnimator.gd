class_name HoneyAnimator
extends Object

const _HoneyConstants := preload("res://addons/HoneyAnimator/Core/HoneyConstants.gd")

const Ease := preload("res://addons/HoneyAnimator/Core/EasingData.tres").data.EasingNames


static func create_honey_animator(node: Node) -> HoneyAnimatorSystem:
	return HoneyAnimatorSystem.new(node)


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
