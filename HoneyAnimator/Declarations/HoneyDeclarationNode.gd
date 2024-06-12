class_name HoneyDeclarationNode
extends HoneyDeclarationBase


func _init(honey_animator: Object,node: Node) -> void:
	_honey_animator = honey_animator
	_node = node


func fade_in(duration: float,self_modulate: bool = false) -> HoneyProperty:
	if self_modulate == true:
		return anima_property("self_modulate", _node.get_modulate(), duration).from(Color.transparent)
	else:
		return anima_property("modulate", _node.get_modulate(), duration).from(Color.transparent)


func fade_out(duration: float,self_modulate: bool = false) -> HoneyProperty:
	if self_modulate == true:
		return anima_property("self_modulate", _node.get_modulate(), duration).from(Color.transparent)
	else:
		return anima_property("modulate", _node.get_modulate(), duration).from(Color.transparent)


func color_to(to_value: Color,duration: float,self_modulate: bool = false) -> HoneyProperty:
	if self_modulate == true:
		return anima_property("self_modulate", to_value, duration)
	else:
		return anima_property("modulate", to_value, duration)


func move_to(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_position_property(_node)
	return anima_property(property, to_value, duration)


func move_to_x(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_position_property(_node,"x")
	return anima_property(property, to_value, duration)


func move_to_y(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_position_property(_node,"y")
	return anima_property(property, to_value, duration)


func move_to_z(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_position_property(_node,"z")
	return anima_property(property, to_value, duration)


func local_move_to(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_local_position_property(_node)
	return anima_property(property, to_value, duration)


func local_move_to_x(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_local_position_property(_node,"x")
	return anima_property(property, to_value, duration)


func local_move_to_y(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_local_position_property(_node,"y")
	return anima_property(property, to_value, duration)


func local_move_to_z(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_local_position_property(_node,"z")
	return anima_property(property, to_value, duration)


func scale_to(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_scale_property(_node)
	return anima_property(property, to_value, duration)


func scale_to_x(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_scale_property(_node,"x")
	return anima_property(property, to_value, duration)


func scale_to_y(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_scale_property(_node,"y")
	return anima_property(property, to_value, duration)


func scale_to_z(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_scale_property(_node,"z")
	return anima_property(property, to_value, duration)


func size_to(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_size_property(_node)
	return anima_property(property, to_value, duration)


func rotation_to(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_rotation_property(_node)
	return anima_property(property, to_value, duration)


func rotation_degrees_to(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_rotation_property(_node)
	return anima_property(property, to_value, duration)


func size_to_x(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_size_property(_node,"x")
	return anima_property(property, to_value, duration)


func size_to_y(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_size_property(_node,"y")
	return anima_property(property, to_value, duration)


func size_to_z(to_value,duration: float) -> HoneyProperty:
	var property := Constants.get_size_property(_node,"z")
	return anima_property(property, to_value, duration)


func shake_position(to_value,duration: float) -> HoneyMethod:
	return 
