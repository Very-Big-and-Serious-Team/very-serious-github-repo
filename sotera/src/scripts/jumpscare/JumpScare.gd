extends Node

class_name JumpScare

enum JumpScareState {
	STARTING_SILENCE, # rand silence at start
	LURE, # start voice,
	PROMISE, # 1 voivce recording has stacked 2nd part "promised me"
	FINISH # jump scare is finished
}

var _state: JumpScareState
var _time: float # timer to trace time of JumpScare states
var _max_time: float # starting time -> used to calculate interpolations/tweens
# var _visual_motion: JumpscareMotion # used for image motion

# group voice
@export var entity_talk: AudioStreamPlayer
var _entity_talk_start_db: float
var _entity_talk_end_db: float
# group voice

@export var impact_scale_curve: Curve
@export var scare_sprite: Sprite2D
var start_scale: float
var end_scale: float
var start_rotation: float
var end_rotation: float

func _process(delta: float) -> void:
	match _state:
		JumpScareState.STARTING_SILENCE: update_starting_silence(delta)
		JumpScareState.LURE: update_lure(delta)
		JumpScareState.PROMISE: update_promise(delta)

func update_starting_silence(delta: float) -> void:
	_time = min(_time + delta, _max_time)
	if _time == _max_time: start_luring()

func update_time_and_db(delta: float) -> void:
	_time = min(_time + delta, _max_time)
	
	var t: float = _time / _max_time
	var alpha: float = TweenUtils.ease_in_out_elastic(t)
	var db = lerp(_entity_talk_start_db, _entity_talk_end_db, alpha)
	entity_talk.volume_db = db

func update_scale_and_opacity() -> void:
	var t: float = _time / _max_time
	var alpha: float = impact_scale_curve.sample(t)
	var scale = lerp(start_scale, end_scale, alpha)
	
	scare_sprite.scale.x = scale
	scare_sprite.scale.y = scale
	scare_sprite.modulate.a = t # opacity
	
	var rad: float = deg_to_rad(lerp(start_rotation, end_rotation, alpha))
	scare_sprite.rotation = rad
	
func update_promise(delta: float) -> void:
	update_time_and_db(delta)
	update_scale_and_opacity()
	
	if _time == _max_time: start_finish()
	
func start_finish() -> void:
	scare_sprite.visible = false
	_state = JumpScareState.FINISH
		
func start_luring():
	_entity_talk_start_db = randf_range(JumpscareConfig.MIN_LURE_VOLUME_DB, JumpscareConfig.MAX_LURE_VOLUME_DB)
	_entity_talk_end_db = randf_range(JumpscareConfig.MIN_START_OF_PROMISIED_DB, JumpscareConfig.MAX_START_OF_PROMISIED_DB)
	
	entity_talk.volume_db = _entity_talk_start_db
	entity_talk.play(0.0) # start voice at 0.0
	_time = 0.0
	_max_time = JumpscareConfig.START_PROMISE_SEC
	
	_state = JumpScareState.LURE
		
func update_lure(delta: float) -> void:
	update_time_and_db(delta)
	if _time == _max_time: start_attack()
	
func start_attack() -> void:
	_entity_talk_start_db = _entity_talk_end_db
	_entity_talk_end_db = randf_range(JumpscareConfig.MIN_END_OF_PROMISIED_DB, JumpscareConfig.MAX_END_OF_PROMISIED_DB)
	
	_time = 0.0
	_max_time = JumpscareConfig.MAX_VOICE_RECORDING_TIME_SEC
	scare_sprite.visible = true
	update_scale_and_opacity()
	
	start_scale = randf_range(JumpscareConfig.MIN_STARTING_SPRITE_JUMP_SCALE, JumpscareConfig.MAX_STARTING_SPRITE_JUMP_SCALE)
	end_scale = randf_range(JumpscareConfig.MIN_END_SPRITE_JUMP_SCALE, JumpscareConfig.MAX_END_SPRITE_JUMP_SCALE)
	
	start_rotation = randf_range(JumpscareConfig.MIN_STARTING_SPRITE_JUMP_ROTATION_DEG, JumpscareConfig.MAX_STARTING_SPRITE_JUMP_ROTATION_DEG)
	end_rotation = randf_range(JumpscareConfig.MIN_END_SPRITE_JUMP_ROTATION_DEG, JumpscareConfig.MAX_END_SPRITE_JUMP_ROTATION_DEG)
	
	_state = JumpScareState.PROMISE

func start_jumpscare() -> void:
	_max_time = randf_range(JumpscareConfig.MIN_STARTING_SILENCE_SEC, JumpscareConfig.MAX_STARTING_SILENCE_SEC)
	_time = 0.0
	_state = JumpScareState.STARTING_SILENCE
	
func _ready() -> void:
	scare_sprite.visible = false # so its not set at start
	start_jumpscare() # used only at testing
	pass
