class_name MiniGameTracker
extends CanvasLayer

@export var max_history: int = 10

# This dictionary will map your game strings ("maze", "bullet") to their PNGs
@export var game_icons: Dictionary 

@onready var container: HBoxContainer = $MarginContainer/HBoxContainer

func _ready() -> void:
	# The moment you re-enter the WheelScene, immediately draw the existing history
	_update_ui()

func add_minigame(game_name: String) -> void:
	Events.minigame_history.append(game_name)
	
	
	if Events.minigame_history.size() > max_history:
		Events.minigame_history.pop_front()
		
	_update_ui()

func _update_ui() -> void:
	for child in container.get_children():
		child.queue_free()
		
	for game in Events.minigame_history:
		var icon_rect = TextureRect.new()
		
		# Look up the correct texture in our dictionary
		if game_icons.has(game) and game_icons[game] != null:
			icon_rect.texture = game_icons[game]
		
		# Keep the UI clean so massive textures don't break the layout
		icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon_rect.custom_minimum_size = Vector2(48, 48) # Adjust this size to match your UI needs
		
		container.add_child(icon_rect)
