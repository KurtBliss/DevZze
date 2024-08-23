class_name CameraController3D
extends Node3D
@export var SpringArm : Node3D ## Used for Pitch, Must be SpringArm (or a Node3D) parent of Camera
@export var SpringArmPivot : Node3D  ## Used for Yaw, Must be Node3D parent of SpringArm

@export_category("(Axis) Input Actions")
@export var left : StringName = ""
@export var right : StringName = ""
@export var up : StringName = ""
@export var down : StringName = ""

func process_move(delta, piv:Node3D = SpringArmPivot, cam:Node3D = SpringArm) -> void:
	move_mouse(delta, piv, cam)
	if left != "":
		move_controller(delta, piv, cam)

func move_controller(delta, piv:Node3D, cam:Node3D) -> void:
	var x = Input.get_axis(left, right)
	var y = Input.get_axis(up, down)
	move(x * delta, y * delta, piv, cam)
 
func move_mouse(delta, piv:Node3D, cam:Node3D) -> void:
	var mouse_motion = Mouse.get_motion()
	move(mouse_motion.x * delta, mouse_motion.y * delta, piv, cam)

func move(x:float, y:float, piv:Node3D, cam:Node3D) -> void:
	piv.rotate_y(-x)
	cam.rotate_x(y)
	cam.rotation_degrees.x = clampf(cam.rotation_degrees.x, -65, 65)
