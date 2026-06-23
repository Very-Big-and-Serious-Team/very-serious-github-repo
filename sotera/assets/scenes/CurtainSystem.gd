extends Node

class_name CurtainSystem

enum CurtainSystemState { IDLE, OPENING_A_LITTLE, OPEN_A_LITTLE, CLOSING_A_LITTLE }

@export var curtain_left: Node2D
@export var curtain_right: Node2D
@export var range_side_offset_x: Vector2 = Vector2(10.0, 20.0)
@export var range_side_offset_y: Vector2 = Vector2(0.0, 2.0)
@export var range_max_open_close_time: Vector2 = Vector2(2.2, 4.6)

var side_offset: Vector2
var origin_left: Vector2
var origin_right: Vector2

var _state: CurtainSystemState
var time: float
var max_time: float

func _ready() -> void:
	origin_left = curtain_left.position
	origin_right = curtain_right.position
	
	side_offset = Vector2(
		randf_range(range_side_offset_x.x, range_side_offset_x.y),
		randf_range(range_side_offset_y.x, range_side_offset_y.y)
	)

func update(delta: float) -> void:
	match(_state):
		CurtainSystemState.OPENING_A_LITTLE: _update_little_opening(delta)
		CurtainSystemState.CLOSING_A_LITTLE: _update_little_closing(delta)
		
func _update_little_opening(delta: float) -> void:
	time = min(time + delta, max_time)
	_update_curtains()
	if time == max_time: _state = CurtainSystemState.OPEN_A_LITTLE
	
func _update_little_closing(delta: float) -> void:
	time = max(time - delta, 0)
	_update_curtains()
	if time == 0: _state = CurtainSystemState.IDLE

func _update_curtains() -> void:
	var t: float = time / max_time
	var alpha: float = TweenUtils.ease_out_quart(t)
	
	var delta_offset: Vector2 = lerp(
		Vector2.ZERO,
		side_offset,
		alpha
	)
	
	curtain_left.position = origin_left - delta_offset
	curtain_right.position = origin_right + delta_offset
	

func open_both_certains_a_little() -> void:
	if _state == CurtainSystemState.OPENING_A_LITTLE: return
	
	time = 0.0
	max_time = randf_range(range_max_open_close_time.x, range_max_open_close_time.y)
	
	_state = CurtainSystemState.OPENING_A_LITTLE
	
func close_both_certains_a_little() -> void:
	_state = CurtainSystemState.CLOSING_A_LITTLE
