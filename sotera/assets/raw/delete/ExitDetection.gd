extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D	) -> void:
	print("You have entered the exit area")	
	# this is meant to be for when they found a contract item within the maze
	# For now after the player touches it we'll just send them back to wheel scene
	Events.change_level("res://assets/scenes/FortuneWheelScene.tscn")
