# HoneyAnimator

HoneyAnimator is an **add-on for Godot 3.x** and will **future avaible for Godot 4.x** soon,was designed to make more ease to do tweening animation was basead on the famous dotween and take from inspiration Anima.

> **NOTE:** HoneyAnimator is currently in early development!

## How To Animate
```gdscript
#Create HoneyAnimator
# Only parameter animator need is node but will change in future
var honey_animator := HoneyAnimator.create_honey_animator(self)
```
# Generic Functions For Nodes
## Move

### **NOTE:** This function use global position
#### move_to(Vector2 or Vector3 target_position, duration float)
Moves the target's position to the given value
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).move_to(Vector2(200,200), 0.5).set_ease(HoneyAnimator.Ease.EaseBackInOut)
```
#### move_to_x/move_to_y/move_to_z(target_position float, duration float)
### move_to_x
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).move_to_x(200, 0.5).set_ease(HoneyAnimator.Ease.EaseBackInOut)
```
### move_to_y
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).move_to_y(200, 0.5).set_ease(HoneyAnimator.Ease.EaseBackInOut)
```
**NOTE:** This Only move_to_z only if is Node3D or Spatial
### move_to_z
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).move_to_z(200, 0.5).set_ease(HoneyAnimator.Ease.EaseBackInOut)
```
### **NOTE:** This function use position
#### local_move_to(Vector2 or Vector3 target_position, duration float)
Moves the target's position to the given value
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).local_move_to(Vector2(200,200), 0.5).set_ease(HoneyAnimator.Ease.EaseBackInOut)
```
#### local_move_to_x/local_move_to_y/local_move_to_z(target_position float, duration float)
### move_to_x
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).local_move_to_x(200, 0.5).set_ease(HoneyAnimator.Ease.EaseBackInOut)
```
### local_move_to_y
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).local_move_to_y(200, 0.5).set_ease(HoneyAnimator.Ease.EaseBackInOut)
```
**NOTE:** This Only move_to_z only if is Node3D or Spatial
### local_move_to_z
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).local_move_to_z(200, 0.5).set_ease(HoneyAnimator.Ease.EaseBackInOut)
```
