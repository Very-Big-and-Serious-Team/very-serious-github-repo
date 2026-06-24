class_name CameraMotion
extends RefCounted

var time: float = randf_range(0.0, 30.5)

# Enable / Disable different motion types
var enable_scale: bool = true
var enable_offset: bool = true
var enable_rotation: bool = true

# Speeds
var scale_speed: Vector2 = Vector2(1.0, 1.0)
var offset_speed: Vector2 = Vector2(0.8, 0.9)
var rotation_speed: float = 0.2

# Limits
var scale_limit: Vector2 = Vector2(0.014, 0.014)
var offset_limit: Vector2 = Vector2(5.4, 5.4)
var rotation_limit: float = deg_to_rad(randf_range(1.8, 2.8))

func get_motion(delta: float) -> Dictionary:
	time += delta

	var motion_scale := Vector2.ZERO
	var motion_offset := Vector2.ZERO
	var motion_rotation := 0.0

	if enable_scale:
		motion_scale = Vector2(
			sin(time * scale_speed.x) * scale_limit.x,
			cos(time * scale_speed.y) * scale_limit.y
		)

	if enable_offset:
		motion_offset = Vector2(
			sin(time * offset_speed.x) * offset_limit.x,
			cos(time * offset_speed.y) * offset_limit.y
		)

	if enable_rotation:
		motion_rotation = sin(time * rotation_speed) * rotation_limit

	return {
		"scale": motion_scale,
		"offset": motion_offset,
		"rotation": motion_rotation
	}
