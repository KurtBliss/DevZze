class_name cBodyHelper3D
extends Object
var body : CharacterBody3D
var pivot : Node3D
var lastx = 0
var lastz = 0
var lastdir = Vector3.ZERO
var yawoffset = PI 
var orientation_node : Node3D = null

func _init(body : CharacterBody3D, pivot : Node3D = null, orientation_node : Node3D = null) -> void:
	self.body = body
	self.pivot = pivot if pivot != null else body
	self.orientation_node = orientation_node 

func turn_self(left: StringName, right: StringName, delta: float) -> void:
	pivot.rotation.y += Input.get_axis(left, right) * delta

func turn_node3d(node3d: Node3D, left: StringName, right: StringName, delta: float) -> void:
	node3d.rotation.y = Input.get_axis(left, right) * delta

func move_slide_gravity(delta: float) -> void:
	body.velocity.y -= delta
	body.move_and_slide()

func movement(left: StringName, right: StringName, up: StringName, down: StringName, delta: float):
	var z = Input.get_axis(up, down)
	var x = Input.get_axis(left, right)
	var dir := Vector3(x,0,z).normalized()
	if is_instance_valid(orientation_node):
		dir = dir.rotated(Vector3.DOWN, -orientation_node.rotation.y)
	body.velocity += dir * delta
	if z!=0 || x!=0:
		lastz = z
		lastx = x
		lastdir = dir

func movement_mesh_direction(mesh: Node3D):
	mesh.rotation.y = Vector2(lastdir.z, lastdir.x).angle() + yawoffset

func friction(weight: float):
	body.velocity = lerp(body.velocity, Vector3(0,body.velocity.y,0), weight)
