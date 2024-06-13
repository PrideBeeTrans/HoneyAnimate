# HoneyAnimator

HoneyAnimator is an **add-on for Godot 3.x** and will **future avaiable for Godot 4.x** soon,was designed to make more ease to do easing animation was basead on the famous dotween and take from inspiration Anima.

> [!WARNING]
> HoneyAnimator is currently in early development!

# How to start
Creating a HoneyAnimator
```gdscript
extends Node

var honey_animator := HoneyAnimator.create_honey_animator()
```

# How To Use
```gdscript
extends Node

var honey_animator := HoneyAnimator.create_honey_animator()
honey_animator.target_node($Sprite)
```

<details>
<summary>Target Node Functions</summary>

## Generic Way
##### anima_property(property: NodePath,to_value,duration: float)
```gdscript
honey_animator.target_node($Sprite).anima_property("position", Vector2.ONE, 0.5)
```

## Move To
### This function use global position!
#### Moves the target's position to the given value as Vector2 or Vector3

##### move_to(target_position: Vector2/Vector3,duration: float)
```gdscript
honey_animator.target_node($Sprite).move_to(Vector2(200,200), 0.5)
```

#### Moves the target's position to the given value as float
#### move_to_x/move_to_y/move_to_z(target_position: float,duration: float)

##### move_to_x(target_position: float,duration: float)
```gdscript
honey_animator.target_node($Sprite).move_to_x(Vector2(200,200), 0.5)
```

##### move_to_y(target_position: float,duration: float)
```gdscript
honey_animator.target_node($Sprite).move_to_y(Vector2(200,200), 0.5)
```

##### move_to_z(target_position: float,duration: float)
```gdscript
honey_animator.target_node($Sprite).move_to_z(Vector2(200,200), 0.5)
```

## Local Move To
### This function use position!
#### Moves the target's position to the given value as Vector2/Vector3

##### local_move_to(target_position: Vector2/Vector3,duration: float)
```gdscript
honey_animator.target_node($Sprite).local_move_to(Vector2(200,200), 0.5)
```

#### Moves the target's position to the given value as float by axis choosed
#### move_to_x/move_to_y/move_to_z(target_position: float,duration: float)

##### local_move_to_x(target_position: float,duration: float)
```gdscript
honey_animator.target_node($Sprite).local_move_to_x(200, 0.5)
```

##### local_move_to_y(target_position: float,duration: float)
```gdscript
honey_animator.target_node($Sprite).local_move_to_y(200, 0.5)
```

#### This only work if is Node3D or Spatial
##### local_move_to_z(target_position: float,duration: float)
```gdscript
honey_animator.target_node($Sprite).local_move_to_z(200, 0.5)
```

## Scale To
#### Scale the target's to the given value as Vector2/Vector3

##### scale_to(target_scale: Vector2 or Vector3,duration: float)
```gdscript
honey_animator.target_node($Sprite).local_move_to(Vector2(200,200), 0.5)
```

#### Scale the target's to the given value as float by axis choosed
#### scale_to_x/scale_to_y/scale_to_z(target_scale: float,duration: float)

##### scale_move_to_x(target_scale: float,duration: float)
```gdscript
honey_animator.target_node($Sprite).scale_to_x(200, 0.5)
```

##### scale_move_to_y(target_scale: float,duration: float)
```gdscript
honey_animator.target_node($Sprite).scale_to_y(200, 0.5)
```

#### This only work if is Node3D or Spatial
##### scale_move_to_z(target_position: float,duration: float)
```gdscript
honey_animator.target_node($Sprite).scale_to_z(200, 0.5)
```
</details>
