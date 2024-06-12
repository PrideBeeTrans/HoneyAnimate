class_name HoneyDeclarationBase
extends Reference

const Constants := preload("res://addons/HoneyAnimator/Core/HoneyConstants.gd")

var _honey_animator : Object
var _node : Node


func anima_property(property: NodePath,to_value,duration: float) -> HoneyProperty:
	var animation_property := HoneyProperty.new(_node)
	_honey_animator.get_animations().append(animation_property)
	return animation_property.anima_property(property, to_value, duration)


func anima_method(method: FuncRef, from, to_value,duration: float) -> HoneyMethod:
	var animation_method := HoneyMethod.new(_node)
	_honey_animator.get_animations().append(animation_method)
	return animation_method.anima_method(method, from, to_value, duration)
