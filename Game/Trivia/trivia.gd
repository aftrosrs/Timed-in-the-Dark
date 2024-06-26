class_name Trivia extends Node2D

@export_category("Stats")
@export_group("Stats")
@export var health: int = 3
@export var questions_answered_correctly: int = 0
@export_category("Arrays")
@export_group("Arrays")
@export var questions: Array[Question]
@export var buttons: Array[Button]
@export_subgroup("Canvas")
@export var canvas_layers: Array[CanvasLayer]
@export var sprites: Array[Sprite2D]


var menu_selector: int = 0
var current_question_index: int = 0

var current_answer_index: int = 0
var correct_answer_index: int = 0
var menu_index: int = 0
var sprite_index: int = 0
var button_select_index: int = 0


@onready var question_field: Label = $"Questions Panel/QuestionsPanel/PanelContainer/Panel/QuestionField"
@onready var question_timer: Label = $"Questions Panel/QuestionsPanel/Question Timer"
@onready var timertimertimertimer: Timer = $Timer
@onready var score_label: Label = $"Questions Panel/QuestionsPanel/Score Label"
@onready var game_over_score: Label = $"Game Over/GameOverScore"
@onready var questions_answered: Label = $"Game Over/QuestionsAnswered"
@onready var color_rect1: ColorRect = $"Questions Panel/QuestionsPanel/HBoxContainer/AnswerButton/ColorRect"
@onready var color_rect2: ColorRect = $"Questions Panel/QuestionsPanel/HBoxContainer/AnswerButton2/ColorRect"
@onready var color_rect3: ColorRect = $"Questions Panel/QuestionsPanel/HBoxContainer2/AnswerButton3/ColorRect"
@onready var color_rect4: ColorRect = $"Questions Panel/QuestionsPanel/HBoxContainer2/AnswerButton4/ColorRect"
@onready var color_rect5: ColorRect = $"Game Over/MarginContainer2/VBoxContainer/HBoxContainer/AnswerButton/ColorRect"
@onready var animation_player: AnimationPlayer = $Hearts/AnimationPlayer
@onready var question_limit_index: int = questions.size()

func _on_timer_timeout() -> void:
	life()
	timertimertimertimer.start()



func _ready() -> void:
	animation_player.play("Idle")
	score_label.text = str("0")
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
	animation_player.play("take damage")
	if sprite_index < sprites.size():
		sprites[sprite_index].visible = false
		timertimertimertimer.paused = true
		await get_tree().create_timer(0.1).timeout
	elif sprite_index > sprites.size() -1:
		sprite_index = 0
	sprite_index += 1
	timertimertimertimer.paused = false
	print(health)
	if health <= 0:
		canvas_layers[1].show()
		canvas_layers[0].hide()
		color_rect_hide()
		game_over_score.text = score_label.text
		if questions_answered_correctly == question_limit_index:
			questions_answered.text = "You answered them all"
		elif questions_answered_correctly <= question_limit_index:
			questions_answered.text = "You answered: " + str(questions_answered_correctly) + " questions correctly"

func next_question():
	score_label.text = str(questions[current_question_index].score)
	questions_answered_correctly += 1
	await get_tree().create_timer(0.0).timeout
	color_rect_show()
	current_question_index += 1
	_updateQuestion()
	_updateAnswer()



func _updateQuestion():
	timertimertimertimer.start()
	timertimertimertimer.paused = true
	for question in questions:
		if current_question_index > questions.size() - 1:
			current_question_index = 0
			#HACK personal way to close game on all questions answered correctly.
			get_tree().quit()#hack replace this line with survive condition.
		question_field.text = questions[current_question_index].question



func _updateAnswer():
	var index = 0
	correct_answer_index = questions[current_question_index].correct_answer_index
	for answer in questions[current_question_index].answers:
		#Loops through each answer of the current question.
		_button_alpha(index)
		_updateText(index, answer)
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
	color_rect_hide()
	timertimertimertimer.paused = false
	

func color_rect_hide():
	color_rect1.hide()
	color_rect2.hide()
	color_rect3.hide()
	color_rect4.hide()
	color_rect5.hide()

func color_rect_show():
	color_rect1.show()
	color_rect2.show()
	color_rect3.show()
	color_rect4.show()

#hack this is required or the entire button appearing system breaks
func _button_alpha(index):
	buttons[index].modulate.a = 0
	#buttons[index].hide()


func _on_answer_button_pressed() -> void:
	pressed(0)



func _on_answer_button_2_pressed() -> void:
	pressed(1)



func _on_answer_button_3_pressed() -> void:
	pressed(2)



func _on_answer_button_4_pressed() -> void:
	pressed(3)


