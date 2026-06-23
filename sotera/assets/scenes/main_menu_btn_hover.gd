extends Control

enum State { GAIN_FOCUS, LOSE_FOCUS, NONE }
var state: State = State.NONE
var time: float

@export var min_scale: float = 1.0
@export var max_scale: float = 1.1
@export var max_time: float = 0.5
@export var crt: CrtControl

# --------------- Used to move curtaints a little on hover ---------------------
@export var curtain_system: CurtainSystem
# --------------- Used to move curtaints a little on hover ---------------------

var motion: CameraMotion = CameraMotion.new()
var base_offset: Vector2

func init_motion() -> void:
	base_offset = position
	motion.enable_scale = false
	motion.enable_offset = true
	motion.enable_rotation = false

func _ready():
	init_motion()
	
	mouse_entered.connect(_on_hover_enter)
	mouse_exited.connect(_on_hover_exit)
	
	scale.x = min_scale
	scale.y = min_scale
	
	
func _process(delta: float) -> void:
	var dict: Dictionary = motion.get_motion(delta)
	position = base_offset + dict["offset"]
	
	if state == State.NONE: return
	
	match state:
		State.GAIN_FOCUS:
			time = min(time + delta, max_time)
			if time == max_time: state = State.NONE
		State.LOSE_FOCUS:
			time = max(time - delta, 0.0)
			if time == 0.0: state = State.NONE
	
	
	var t: float = time / max_time
	var calc_scale: float = lerp(min_scale, max_scale, t)
	
	scale.x = calc_scale
	scale.y = calc_scale
	
	curtain_system.update(t)

func _on_hover_enter():
	var uv_mouse_pos = ScreenUtils.uv_mouse_position(
		get_viewport().get_mouse_position(),
		get_viewport().get_visible_rect().size
	)

	# all triggered aniamtions -> player visaul feedback
	crt.start_darken(uv_mouse_pos)
	curtain_system.open_both_certains_a_little()
	# all triggered aniamtions -> player visaul feedback
	
	state = State.GAIN_FOCUS
	time = 0.0

func _on_hover_exit():
	# all triggered aniamtions -> player visaul feedback
	crt.stop_darken()
	curtain_system.close_both_certains_a_little()
	# all triggered aniamtions -> player visaul feedback
	
	state = State.LOSE_FOCUS
	time = max_time
