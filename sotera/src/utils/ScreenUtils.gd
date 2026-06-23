class_name ScreenUtils

#Dummy constructor to prevent idiots calling .new()
func _init() -> void:
	assert(false, "Use RandUtils.target_function() instead")

static func uv_mouse_position(mouse_pos: Vector2, viewport_size: Vector2) -> Vector2:
	return Vector2(
		clamp(mouse_pos.x / viewport_size.x, 0.0, 1.0),
		clamp(mouse_pos.y / viewport_size.y, 0.0, 1.0)
	)
