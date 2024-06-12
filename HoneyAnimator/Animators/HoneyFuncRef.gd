class_name HoneyFuncRef
extends HoneyAnimation


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
