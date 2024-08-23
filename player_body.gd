class_name PlayerBody
extends CharacterBody3D
@onready var bodyHelper = cBodyHelper3D.new(self, self, $CameraController)

func _ready() -> void:
	Mouse.set_game_toggle(true)

func _physics_process(delta: float) -> void:
	$CameraController.process_move(delta)
	bodyHelper.movement("left","right","up", "down", delta * 100)
	bodyHelper.movement_mesh_direction($MeshInstance3D)
	bodyHelper.friction(0.5)
	bodyHelper.move_slide_gravity(delta)
