extends Control

@export var questions: Array[Question]
@onready var question_label: Label = $QuestionLabel
@onready var option_a: Button = $Options/VBoxContainer/OptionA
@onready var option_b: Button = $Options/VBoxContainer/OptionB
@onready var option_c: Button = $Options/VBoxContainer2/OptionC
@onready var option_d: Button = $Options/VBoxContainer2/OptionD


var num_of_question: int
var curent_question: Question
var question_index: int = 0

func _ready() -> void:
	num_of_question = questions.size()
	if num_of_question == 0:
		return

	curent_question = questions[question_index]
	question_label.text = curent_question.question
	option_a.text = curent_question.option_a
	option_b.text = curent_question.option_b
	option_c.text = curent_question.option_c
	option_d.text = curent_question.option_d

func move_to_next_question() -> void:
	if question_index >= num_of_question - 1:
		return

	question_index += 1 
	curent_question = questions[question_index]
	question_label.text = curent_question.question
	option_a.text = curent_question.option_a
	option_b.text = curent_question.option_b
	option_c.text = curent_question.option_c
	option_d.text = curent_question.option_d


func _on_option_a_pressed() -> void:
	if curent_question.answer == 1:
		print("your are right")
		on_right_answer()
	else:
		print("you are wrong")
		on_wrong_answer()

	move_to_next_question()

func _on_option_b_pressed() -> void:
	if curent_question.answer == 2:
		print("your are right")
		on_right_answer()
	else:
		print("you are wrong")
		on_wrong_answer()

	move_to_next_question()


func _on_option_c_pressed() -> void:
	if curent_question.answer == 3:
		print("your are right")
		on_right_answer()
	else:
		print("you are wrong")
		on_wrong_answer()
	move_to_next_question()


func _on_option_d_pressed() -> void:
	if curent_question.answer == 4:
		print("your are right")
		on_right_answer()
	else:
		print("you are wrong")
		on_wrong_answer()
	move_to_next_question()

func on_right_answer() -> void:
	pass

func on_wrong_answer() -> void:
	pass
