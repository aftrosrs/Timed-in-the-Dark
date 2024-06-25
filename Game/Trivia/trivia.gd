extends Node2D

@export var health: int = 20
@export var questions: Array[Question]
@export var buttons: Array[Button]
@export var menus: Array[PackedScene]
var menu_selector: int = 0
var current_question_index: int = 0
var question_limit_index: int = 6
var current_answer_index: int = 0
var correct_answer_index: int = 0
var menu_index: int = 0
@onready var question_field: Label = $QuestionsPanel/VBoxContainer/MarginContainer/VBoxContainer/PanelContainer/Panel/QuestionField
@onready var question_timer: Label = $"QuestionsPanel/Question Timer"
@onready var timertimertimertimer: Timer = $Timer


func _on_timer_timeout() -> void:
	life()




func _ready() -> void:
	_updateQuestion()
	_updateAnswer()


func _process(delta: float) -> void:
	_updateQuestion_Timer()

func pressed(button_index: int):
	if button_index == questions[current_question_index].correct_answer_index:
		questions[current_question_index].correct_answer_index = questions[current_question_index].correct_answer_index
		next_question()
		
	else:
		life()


func _updateQuestion_Timer():
	question_timer.text =  "%.2f" % timertimertimertimer.time_left


func life():
	health -= 1
	timertimertimertimer.start()
	print(health)
	if health <= 0:
		get_tree().change_scene_to_packed(menus[0])

func next_question():
	await get_tree().create_timer(0.1).timeout
	timertimertimertimer.start()
	current_question_index += 1
	_updateQuestion()
	_updateAnswer()

#func restart_question_timer():
	#var timer_better_work_damnit = get_tree().create_timer(10)
	#timer_better_work_damnit.timeout.connect(life)

func _updateQuestion():
	for question in questions:
		if current_question_index > questions.size() - 1:
			current_question_index = 0
			#HACK personal way to close game on all questions answered correctly.
			get_tree().quit()
		question_field.text = questions[current_question_index].question
		timertimertimertimer.start()


func _updateAnswer():
	var index = 0
	for answer in questions[current_question_index].answers:
		#Loops through each answer of the current question.
		_button_alpha(index)
		_updateText(index, answer)
		correct_answer_index = questions[index].correct_answer_index
		index += 1


func _updateText(index, answer):#sets the button text to the answer found
	buttons[index].text = answer
	buttons[index].hide()
	await get_tree().create_timer(3).timeout
	buttons[0].show()
	buttons[0].modulate.a = 1.0
	await get_tree().create_timer(3).timeout
	buttons[1].show()
	buttons[1].modulate.a = 1.0
	await get_tree().create_timer(3).timeout
	buttons[2].show()
	buttons[2].modulate.a = 1.0
	await get_tree().create_timer(3).timeout
	buttons[3].show()
	buttons[3].modulate.a = 1.0




func _button_alpha(index):
	buttons[index].modulate.a = 0



func _on_answer_button_pressed() -> void:
	pressed(0)
	


func _on_answer_button_2_pressed() -> void:
	pressed(1)
	


func _on_answer_button_3_pressed() -> void:
	pressed(2)
	


func _on_answer_button_4_pressed() -> void:
	pressed(3)
	


