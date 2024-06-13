# HoneyAnimator

HoneyAnimator is an **add-on for Godot 3.x** and will **future avaible for Godot 4.x** soon,was designed to make more ease to do tweening animation was basead on the famous dotween and take from inspiration Anima.

> [!WARNING]
> HoneyAnimator is currently in early development!


## How To Start
```gdscript
#Create HoneyAnimator
var honey_animator := HoneyAnimator.create_honey_animator()
```

## HoneyAnimator Functions

func reset(id = null)

func reset_all()


func resume(id = null)

func resume_all()

func pause(id = null)

func pause_all()

func play(id = null)

func play_all()

func play_backwards_all(id = null)

func play_backwards()

func play_forward_all(id = null)

func play_forward()

func stop(id = null)

func stop_all()

func flip(id = null)

func flip_all()

func restart_all(include_delay: bool = true, change_delay_to: float = -1.0)

func restart(id: int, include_delay: bool = true, change_delay_to: float = -1.0)

func rewind_all(include_delay: bool = true)

func rewind(id: int, include_delay: bool = true)


# Generic Functions For Nodes
> [!NOTE]
> This function use global position
#### move_to(Vector2 or Vector3 target_position, duration float)
> Moves the target's position to the given value as Vector2 or Vector3
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).move_to(Vector2(200,200), 0.5)
```
#### move_to_x/move_to_y/move_to_z(target_position float, duration float)
### move_to_x
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).move_to_x(200, 0.5)
```
### move_to_y
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).move_to_y(200, 0.5)
```
### move_to_z
>**NOTE:** This Only move_to_z only if is Node3D or Spatial
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).move_to_z(200, 0.5)
```

>### **NOTE:** This function use position
#### local_move_to(Vector2 or Vector3 target_position, duration float)
> Moves the target's position to the given value
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).local_move_to(Vector2(200,200), 0.5)
```
#### local_move_to_x/local_move_to_y/local_move_to_z(target_position float, duration float)
### local_move_to_x
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).local_move_to_x(200, 0.5)
```
### local_move_to_y
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).local_move_to_y(200, 0.5)
```
### local_move_to_z
>**NOTE:** This Only move_to_z only works if is Node3D or Spatial
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).local_move_to_z(200, 0.5)
```


## Scale
#### scale_to(Vector2 or Vector3 target_position, duration float)
> Change the target's scale to the given value
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).scale_to(Vector2(200,200), 0.5)
```
#### scale_to_x/scale_to_y/scale_to_z(target_position float, duration float)
> Change the target's scale to the given value
### scale_to_x
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).scale_to_x(200, 0.5)
```
### scale_to_y
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).scale_to_y(200, 0.5)
```

### scale_to_z
>**NOTE:** This Only scale_to_z only works if is Node3D or Spatial
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).scale_to_z(200, 0.5)
```


## Color
### color_to
> Change the target's color to the given value
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_node($Sprite).color_to(to_value: Color,duration: float,self_modulate: bool = false)
```

# Virtual Functions

### target_float(from: float,to: float,duration: float)
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_float(from, to, duration)
```

### target_vector2(from: Vector2,to: Vector2,duration: float)
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_vector2(from, to, duration)
```

### target_vector3(from: Vector3,to: Vector3,duration: float)
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_vector3(from, to, duration)
```

### target_int(from: int,to: int,duration: float)
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_int(from, to, duration)
```

### target_rect2(from: Rect2,to: Rect2,duration: float)
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_rect2(from, to, duration)
```

### target_transform3d
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_transform3d(from, to, duration)
```

### target_aabb
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_aabb(from: AABB,to: AABB,duration: float)
```

### target_quad(from: Quat,to: Quat,duration: float)
```gdscript
var honey_animator := HoneyAnimator.create_honey_animator(self)
honey_animator.target_quad(from: Quat,to: Quat,duration: float)
```

# Animations CallBacks

## OnStarted
on_started(funcref: FuncRef)
Sets a callback that will be fired once when the tween starts (meaning when the tween is set in a playing state the first time, after any eventual delay).
