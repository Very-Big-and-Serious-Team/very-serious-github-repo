extends Control

class_name CrtControl

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var crt_motion: CrtMotion


func _ready() -> void:
	crt_motion = CrtMotion.new($ColorRect)
	adjust_to_full_screen()
	
	Events.level_change_start.connect(fade_out)
	Events.level_change_enter.connect(fade_in)
	Events.play_loading_screen.connect(load_screen)
	Events.stop_loading_screen.connect(stop_load_screen)

func _process(delta: float) -> void:
	crt_motion.update(delta)

func fade_out() -> void:
	animation_player.play("fade_to_black")
	# Wait until screen is black
	await animation_player.animation_finished
	Events.fade_out_done.emit()

func fade_in() -> void:
	animation_player.play_backwards("fade_to_black")
	await animation_player.animation_finished

func load_screen() -> void:
	# Show black screen
	$LoadingScreen.show()

func stop_load_screen() -> void:
	# Hides black screen
	$LoadingScreen.hide()

func adjust_to_full_screen() -> void:
	var full_screen_size: Vector2 = get_viewport_rect().size
	var zero: Vector2 = Vector2.ZERO
	
	position = zero
	$ColorRect.position = zero
	$ColorRect2.position = zero
	
	size = full_screen_size
	$ColorRect.size = full_screen_size
	$ColorRect2.size = full_screen_size
	
func start_darken(focus_origin: Vector2) -> void:
	crt_motion.start_darken(focus_origin)
	
func stop_darken() -> void:
	crt_motion.start_lighten()
	
func reset() -> void:
	crt_motion.reset()
