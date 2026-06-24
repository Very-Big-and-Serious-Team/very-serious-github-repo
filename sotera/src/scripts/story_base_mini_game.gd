extends Control

enum Answers {A, B, C, D}

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
	
	option_a.pressed.connect(_on_option_pressed.bind(Answers.A))
	option_b.pressed.connect(_on_option_pressed.bind(Answers.B))
	option_c.pressed.connect(_on_option_pressed.bind(Answers.C))
	option_d.pressed.connect(_on_option_pressed.bind(Answers.D))
	
	display_question()
	option_a.grab_focus()
	

func move_to_next_question() -> void:
	if question_index >= num_of_question - 1:
		print("you finsh the quiz")
		return
	question_index += 1 
	display_question()


func display_question():
	curent_question = questions[question_index]
	curent_question = questions[question_index]
	question_label.text = curent_question.question
	option_a.text = curent_question.option_a
	option_b.text = curent_question.option_b
	option_c.text = curent_question.option_c
	option_d.text = curent_question.option_d


func _on_option_pressed(chosen_answer: Answers) -> void:
	if chosen_answer == curent_question.answer:
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
