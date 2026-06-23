extends Node

@onready var options: HBoxContainer = $Options
@onready var fight_run: VBoxContainer = $FightRun



func _on_fight_button_pressed() -> void:
	fight_run.visible = false
	options.visible = true
	
