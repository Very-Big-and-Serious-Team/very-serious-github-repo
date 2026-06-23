class_name Combatant
extends Node2D

enum Emotion { NEUTRAL, HAPPY, ANGRY, SAD }

@export var character_name: String 
@export var max_hp: int = 1
@export var attack_damage: int = 1 

var current_hp: int 
var current_emotion: Emotion = Emotion.NEUTRAL
 
func _ready() -> void:
	current_hp = max_hp

func _take_damage(amount: int) -> void:
	current_hp -= amount

func _heal(amount: int) -> void:
	current_hp += amount
	if current_hp <= 0:
		on_death()

func on_death() -> void:
	print(str(character_name) + " is dead")
