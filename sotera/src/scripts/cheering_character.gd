extends Node2D


enum States{SIT_IDLE, MOVING_TO_TARGE_SIT, MOVING_OUT, CHEERING}

@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export_range(1, 3) var fun_level: int
@export var min_wait_time: int = 5
@export var max_wait_time: int = 10 
@export var speed: int = 100

var direction: Vector2
var active_state: States
var cheering_character_spawner: Node2D
var seat: Vector2

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	on_start_sit_idle()


func _physics_process(delta: float) -> void:
	match active_state:
		States.SIT_IDLE:
			pass
		States.MOVING_TO_TARGE_SIT:
			move_to_target_sit(delta)
		States.MOVING_OUT:
			move_out(delta)
		States.CHEERING:
			cheering()

func on_start_sit_idle():
	active_state = States.SIT_IDLE
	timer.wait_time = randi_range(min_wait_time, max_wait_time)
	timer.start()

func on_start_cheering() -> void:
	timer.wait_time = randi_range(min_wait_time, max_wait_time)
	timer.start()
	active_state = States.CHEERING

func on_start_move_to_target_seat() -> void:
	cheering_character_spawner.change_seat_state(seat, false)
	seat = cheering_character_spawner.find_free_seat()
	active_state = States.MOVING_TO_TARGE_SIT

func on_start_move_out():
	var left_or_right: int = 1 if randf() > 0.5 else -1
	direction = Vector2(left_or_right, 0)
	active_state = States.MOVING_OUT
	cheering_character_spawner.change_seat_state(seat, false)

func move_out(delta: float) -> void:
	global_position += direction * speed * delta
	if global_position.distance_to(seat) > 1000:
		queue_free()

func move_to_target_sit(delta) -> void:
	global_position += (seat - global_position).normalized() * delta * speed
	if global_position.distance_to(seat) < 100:
		on_sit_end()

func cheering() -> void:
	pass

func _on_timer_timeout() -> void:
	timer.stop()
	match active_state:
		States.SIT_IDLE:
			on_sit_end()
		States.MOVING_TO_TARGE_SIT:
			pass
		States.MOVING_OUT:
			pass
		States.CHEERING:
			on_cheering_end()

func on_cheering_end() -> void:
	var rnd_num: float = randf()
	var chance_to_cheer_again: float

	match fun_level:
		1: chance_to_cheer_again = 0.20
		2: chance_to_cheer_again = 0.40
		3: chance_to_cheer_again = 0.70

	if rnd_num <= chance_to_cheer_again:
		on_start_cheering()
	else:
		var remaining_roll: int = randi_range(1, 3)
		match remaining_roll:
				1:
					on_start_sit_idle()
					print("on_start_sit_idle")
				2:
					on_start_move_to_target_seat()
					print("move_to_target_sit")

				3:
					on_start_move_out()
					print("move_out")

func on_sit_end():
	var rnd_num: int = randi_range(1, 4) 
	print("sit end "+ str(rnd_num))
	match rnd_num:
			1:
				on_start_sit_idle()
				print("on_start_sit_idle")
			2:
				on_start_move_to_target_seat()
				print("move_to_target_sit")

			3:
				on_start_move_out()
				print("move_out")

			4:
				on_start_cheering()
				print("on_start_cheering")
