extends Node2D

@onready var cheering_charater_spawner: Node2D = $CheeringCharaterSpawner

@export var space_between_seats_x: int
@export var space_between_seats_y: int
@export var seat_whidth: int = 50
@export var seat_height: int = 50
@export var theater_whidth = 1920

#seat poseation and is seat taken
var seats: Dictionary[Vector2, bool]
var seat_size: Vector2
var num_of_seats_per_row: int


 
func _ready() -> void:
	on_start()
	cheering_charater_spawner.seats = seats
	cheering_charater_spawner.max_characters = seats.size() + 5
	print(seats.size())

func on_start() -> void:
	num_of_seats_per_row = int(theater_whidth / (space_between_seats_x + seat_whidth)) + 2
	var seat_poseation: Vector2 =  Vector2(0 - space_between_seats_x - seat_whidth, 100)
	for i in range(3):
		for seat in range(num_of_seats_per_row):
			seats[seat_poseation] = false
			seat_poseation.x += seat_whidth + space_between_seats_x
		seat_poseation.y += space_between_seats_y + seat_height
		seat_poseation.x = 0 -space_between_seats_x - seat_whidth
