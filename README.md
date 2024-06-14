# HoneyAnimator Documentation

HoneyAnimator is an **add-on for Godot 3.x**, with **future support planned for Godot 4.x**. It simplifies easing animations, inspired by DOTween and Anima.

> [!WARNING]
> HoneyAnimator is currently in early development!

## Table of Contents

1. [Getting Started](#getting-started)
2. [How Install](#how-install)
3. [Usage](#usage)
4. [Animator Functions](#animator-functions)
    - [Play](#play)
    - [Play_All](#play-all)
    - [Play_Backwards](#play-backwards)
    - [Play_All Backwards](#play-all-backwards)
    - [Play_Forward](#play-forward)
    - [Play_Forward_All](#play-all-forward)
    - [Restart](#restart)
    - [Restart_All](#restart-all)
    - [Rewind](#rewind)
    - [Rewind_All](#rewind-all)
    - [Kill](#kill)
    - [Flip_All](#flip-all)
    - [Flip](#flip)
    - [Set_Auto_Start](#set-auto-start)
    - [Is_Running](#is-running)
    - [Is_Paused](#is-paused)
    - [Is_Auto_Start](#is-auto-start)
    - [Get_Animations](#get-animations)
    - [Get_Paused_Animations](#get-paused-animations)
    - [Get_Running_Animations](#get-running-animations)
    - [Get_Animations_By_Id](#get-animations-by-id)
    - [Get_Total_Animations_By_Id](#get-total-animations-by-id)
    - [Get_Total_Animations_Loops](#get-total-animations-loops)
5. [Target Node Functions](#target-node-functions)
   - [Generic Animation](#generic-animation)
       - [Animate Property](#animate-property)
       - [Animate Method](#animate-method)
   - [Move To](#move-to)
       - [Move To X](#move-to-x)
       - [Move To Y](#move-to-y)
       - [Move To Z](#move-to-z)
   - [Local Move To](#move-to)
       - [Local Move To X](#local-move-to-x)
       - [Local Move To Y](#local-move-to-y)
       - [Local Move To Z](#local-move-to-z)
   - [Scale To](#scale-to)
	   - [Scale To X](#scale-to-x)
	   - [Scale To Y](#scale-to-y)
	   - [Scale To Z](#scale-to-z)
    - [Color To](#color-to)
    - [Rotation To](#rotation-to)
    - [Rotation Degrees To](#rotation-degrees-to)
    - [Squash To](#squash-to)
    - [Stretch To](#stretch-to)

# Getting Started

### Creating a HoneyAnimator

To create a HoneyAnimator instance, extend your node script and instantiate the HoneyAnimator:

```gdscript
extends Node

# Create a HoneyAnimator instance
var honey_animator := HoneyAnimator.create_honey_animator()

```

# Usage
### Here is a basic example of how to use HoneyAnimator to animate a Sprite node:

```gdscript
extends Node

# Create a HoneyAnimator instance
var honey_animator := HoneyAnimator.create_honey_animator()

# Set the target node to animate
honey_animator.target_node($Sprite)
```

## Animator Functions

#### Play
`play(id: Variant)`Plays the animation with the specified ID.

Parameters:
- `id` (Variant): The ID of the animation to play.

Example Usage:

```gdscript
honey_animator.play("Group")
```

#### Play All
`play_all()`Plays all animations.

Example Usage:

```gdscript
honey_animator.play_all()
```

#### Play Backwards
`play_backwards(id: Variant)`Plays the animation with the specified ID backwards.

Parameters:
- `id` (Variant): The ID of the animation to play backward.

Example Usage:

```gdscript
honey_animator.play_backwards(Vector2(1,1))
```

#### Play All Backwards
`play_all_backwards()`Plays all animations backwards.

Example Usage:

```gdscript
honey_animator.play_all_backwards()
```

#### Play Forward
`play_forward(id: Variant)`Plays the animation with the specified ID forward.

Parameters:
- `id` (Variant): The ID of the animation to play forward.

Example Usage:

```gdscript
honey_animator.play_forward(Vector2(1,1))
```

#### Play All Forward
`play_all_forward()`Plays all animations.

Example Usage:

```gdscript
honey_animator.play_all_forward()
```

#### Restart
`restart(id: Variant)`Restarts the animation with the specified ID.

Parameters:
- `id` (int): The ID of the animation to restart.
- `include_delay` (bool, default = true): Whether to include the delay.
- `change_delay_to` (float, default = -1.0): The new delay to set.

Example Usage:

```gdscript
honey_animator.restart(Vector2(1,1))
```

#### Restart All
`restart_all()`Restarts all animations.

Parameters:

- `include_delay` (bool, default = true): Whether to include the delay.
- `change_delay_to` (float, default = -1.0): The new delay to set.

Example Usage:

```gdscript
honey_animator.restart_all()
```

#### Rewind
`rewind(id: Variant)`Rewinds the animation with the specified ID.

Parameters:
- `id` (int): The ID of the animation to rewind.
- `include_delay` (bool, default=true): Whether to include the delay.

Example Usage:

```gdscript
honey_animator.rewind(Vector2(1,1))
```

#### Rewind All
`rewind_all()`Rewinds all animations.

Parameters:

- `include_delay` (bool, default=true): Whether to include the delay.

Example Usage:

```gdscript
honey_animator.rewind_all()
```

## Target Node Functions
### Generic Animation

#### Animate Property
`anima_property(property, to_value, duration)`Animates a specified property of the target node to a given value over the specified duration.

#### Parameters:

- `property` (NodePath): The property of the target node to animate.
- `to_value` (Variant): The final value to animate the property to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
#Animate the position property of the target node to Vector2.ONE over 0.5 seconds
honey_animator.target_node($Sprite).anima_property("position", Vector2.ONE, 0.5)
```


#### Animate Method
`anima_method(method, from, to, duration)` Animates a method call on the target node from a specified starting value to an end value over the given duration.

#### Parameters:

- `method` (FuncRef): The method reference to animate.
- `from` (Variant): The initial value to start the animation from.
- `to_value` (Variant): The final value to animate to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
#Animate the position property of the target node to Vector2.ONE over 0.5 seconds
honey_animator.target_node($Sprite).anima_method(funcref, from, to_value, duration)
```

## Move To
`move_to(target_position, duration)`Moves the target's global position to the specified value.

#### Parameters:

- `target_position` (Vector2/Vector3): The position to move the target to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
# Move the target node to the global position (200, 200) over 0.5 seconds
honey_animator.target_node($Sprite).move_to(Vector2(200, 200), 0.5)
```

## Move To X

`move_to_x(target_position, duration)`Moves the target's global X position.

Parameters:

- `target_position` (float): The X position to move the target to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
# Move the target node's global X position to 200 over 0.5 seconds
honey_animator.target_node($Sprite).move_to_x(200, 0.5)
```

## Move To Y

`move_to_y(target_position, duration)`Moves the target's global Y position.

Parameters:

- `target_position` (float): The Y position to move the target to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
# Move the target node's global Y position to 200 over 0.5 seconds
honey_animator.target_node($Sprite).move_to_y(200, 0.5)
```

## Move To Z

`move_to_z(target_position, duration)`Moves the target's global Z position (for 3D nodes).

Parameters:

- `target_position` (float): The Z position to move the target to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
# Move the target node's global Z position to 200 over 0.5 seconds
honey_animator.target_node($Sprite3D).move_to_z(200, 0.5)
```

##  Local Move To
`local_move_to(target_position, duration)`Moves the target's local position to the specified value.

#### Parameters:

- `target_position` (Vector2/Vector3): The position to move the target to.
- `duration`` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
# Move the target node to the local position (200, 200) over 0.5 seconds
honey_animator.target_node($Sprite).local_move_to(Vector2(200, 200), 0.5)
```

## Local Move To X

`local_move_to_x(target_position, duration)`Moves the target's local X position.

Parameters:

- `target_position` (float): The X position to move the target to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
# Move the target node's local X position to 200 over 0.5 seconds
honey_animator.target_node($Sprite).local_move_to_x(200, 0.5)
```

## Local Move To Y

`local_move_to_y(target_position, duration)`Moves the target's local Y position.

Parameters:

- `target_position` (float): The Y position to move the target to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
# Move the target node's local Y position to 200 over 0.5 seconds
honey_animator.target_node($Sprite).move_to_y(200, 0.5)
```

## Local Move To Z

`local_move_to_z(target_position, duration)`Moves the target's local Z position (for 3D nodes).

Parameters:

- `target_position` (float): The Z position to move the target to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
# Move the target node's global Z position to 200 over 0.5 seconds
honey_animator.target_node($Sprite3D).local_move_to_z(200, 0.5)
```


## Scale To
`scale_to(target_scale, duration)` Animates the target scale to the specified value.

Parameters:

- `target_scale` (Vector2/Vector3): The scale to animate the target to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:


```gdscript
# Scale the target node to (2, 2) over 0.5 seconds
honey_animator.target_node($Sprite).scale_to(Vector2(2, 2), 0.5)
```

## Scale To X
`scale_to_x(target_scale, duration)`Animates the target's X scale to the specified value.

Parameters:

- `target_scale` (float): The X scale to animate the target to.
- `duration` (float): The duration over which the animation occurs.

Example Usage:
```gdscript
# Scale the target node's X axis to 200 over 0.5 seconds
honey_animator.target_node($Sprite).scale_to_x(200, 0.5)
```


## Scale To Y
`scale_to_y(target_scale, duration)`Animates the target's Y scale to the specified values.

Parameters:

- `target_scale` (float): The Y scale to animate the target to.
- `duration (float)`: The duration over which the animation occurs.

Example Usage:
```gdscript
# Scale the target node's Y axis to 200 over 0.5 seconds
honey_animator.target_node($Sprite).scale_to_y(200, 0.5)
```

## Scale To Z
`scale_to_z(target_scale, duration)`Animates the target's Z scale to the specified value (for 3D nodes).

Parameters:

- `target_scale` (float): The Z scale to animate the target to.
- `duration` (float): The duration over which the animation occurs.


Example Usage:
```gdscript
# Scale the target node's z axis to 200 over 0.5 seconds
honey_animator.target_node($Sprite3D).scale_to_z(200, 0.5)
```

## Color To
`color_to(target_color, duration)`Animates the target node's color to the specified value over the given duration. Optionally, it can animate the `self_modulate` property instead of the `modulate` property.

Parameters:

- `to_value` (Color): The target color to animate to.
- `duration` (float): The duration over which the animation occurs.
- `self_modulate` (bool, default: false): If `true`, the animation affects the `self_modulate` property instead of the `modulate` property.


Example Usage:

```gdscript
honey_animator.target_node($Sprite).color_to(Color(1, 0, 0), 0.5)
```
Animates the target node's color to red over 0.5 seconds. To animate the `self_modulate` property instead, set the `self_modulate` parameter to true:
```gdscript
honey_animator.target_node($Sprite).color_to(Color(1, 0, 0), 0.5, true)
```

## Rotation To
`rotation_to(to_value, duration)`Animates the target node's `rotation` (in radians) to the specified value over the given duration.


Parameters:

- `to_value` (float): The target rotation in radians.
- `duration` (float): The duration over which the animation occurs.


Example Usage:

```gdscript
honey_animator.target_node($Sprite).rotation_to(PI, 0.5)
```

## Rotation Degrees To
`rotation_degrees_to(to_value, duration)`Animates the target node's rotation (in degrees) to the specified value over the given duration.


Parameters:

- `to_value` (float): The target rotation in degrees.
- `duration` (float): The duration over which the animation occurs.


Example Usage:

```gdscript
honey_animator.target_node($Sprite).rotation_degrees_to(180, 0.5)
```


## Squash To
`squash_to(squash_intesity, reset_scale, duration)`Animates the target node's squash to the specified intensity over the given duration.

Parameters:

- `squash_intensity` (float): The intensity of the squash effect.
- `reset_scale` (Vector2/Vector3): The scale to reset to after squashing.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
honey_animator.target_node($Sprite).squash_to(0.5, Vector2(1, 1), 0.5)
```


## Stetch To
`stretch_to(stretch_intesity, reset_scale, duration)`Animates the target node's stretch to the specified intensity over the given duration.

Parameters:

- `stretch_intesity` (float): The intensity of the stretch effect.
- `reset_scale` (Vector2/Vector3): The scale to reset to after stretching.
- `duration` (float): The duration over which the animation occurs.

Example Usage:

```gdscript
honey_animator.target_node($Sprite).stretch_to(0.5, Vector2(1, 1), 0.5)
```
