class_name Trivia extends Node2D


@export_category("Stats")
@export_group("Stats")
@export_subgroup("Stats")
@export var health: int = 3
@export_subgroup("Questions Answered Correctly")
@export var questions_answered_correctly: int = 0
@export_category("Arrays")
@export_group("Arrays")
@export_subgroup("Questions")
@export var questions: Array[Question]
@export_subgroup("Buttons")
@export var buttons: Array[Button]
@export_subgroup("Canvas")
@export var canvas_layers: Array[CanvasLayer]
@export_subgroup("Sprites")
@export var sprites: Array[Sprite2D]
@export_subgroup("Timers")
@export var timers: Array[Timer]

var menu_selector: int = 0
var current_question_index: int = 0
var current_answer_index: int = 0
var correct_answer_index: int = 0
var menu_index: int = 0
var sprite_index: int = 0
var button_select_index: int = 0


@onready var color_rect1: ColorRect = $"Questions Panel/QuestionsPanel/HBoxContainer/AnswerButton/ColorRect"
@onready var color_rect2: ColorRect = $"Questions Panel/QuestionsPanel/HBoxContainer/AnswerButton2/ColorRect"
@onready var color_rect3: ColorRect = $"Questions Panel/QuestionsPanel/HBoxContainer2/AnswerButton3/ColorRect"
@onready var color_rect4: ColorRect = $"Questions Panel/QuestionsPanel/HBoxContainer2/AnswerButton4/ColorRect"
@onready var color_rect5: ColorRect = $"Game Over/MarginContainer2/VBoxContainer/HBoxContainer/AnswerButton/ColorRect"
@onready var animation_player: AnimationPlayer = $Hearts/AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $Hearts/AnimationPlayer2
@onready var animation_player_3: AnimationPlayer = $Hearts/AnimationPlayer3
@onready var animation_player_4: AnimationPlayer = $AspectRatioContainer/AnimationPlayer4
@onready var question_limit_index: int = questions.size()
@onready var score_label: Label = $"Questions Panel/QuestionsPanel/Score Label"
@onready var soul_claimed: Label = $"Game Over/MarginContainer/CenterContainer/VBoxContainer/MarginContainer/PanelContainer/Panel/SoulClaimed"
@onready var game_over_score: Label = $"Game Over/GameOverScore"
@onready var questions_answered: Label = $"Game Over/QuestionsAnswered"
@onready var question_number: Label = $"Questions Panel/QuestionsPanel/PanelContainer/Panel/QuestionNumber"
@onready var question_value: Label = $"Questions Panel/QuestionsPanel/PanelContainer/Panel/QuestionValue"
@onready var question_field: Label = $"Questions Panel/QuestionsPanel/PanelContainer/Panel/QuestionField"
@onready var question_timer: Label = $"Questions Panel/QuestionsPanel/Question Timer"
@onready var music: AudioStreamPlayer = $Node/Music



func _ready() -> void:
	timers[0].start()
	timers[0].paused = true
	music.autoplay = true
	animation_player.play("Idle")
	animation_player_4.play("background")
	question_timer.text = str("Time: ") + "%.2f" % + timers[0].time_left
	score_label.text = str("0") + " Souls"
	_updateQuestion()
	_updateAnswer()


func _on_timer_timeout() -> void:
	heart_shake()
	life()
	timers[0].start()

func _process(delta: float) -> void:
	_updateQuestion_Timer()

func pressed(button_index: int):
	if button_index == questions[current_question_index].correct_answer_index:
		questions[current_question_index].correct_answer_index = questions[current_question_index].correct_answer_index
		next_question()
	else:
		buttons[button_index].modulate.a = 0
		buttons[button_index].process_mode = Node.PROCESS_MODE_DISABLED
		heart_shake()
		life()

func reset_button_process_mode():
	buttons[0].process_mode = Node.PROCESS_MODE_INHERIT
	buttons[1].process_mode = Node.PROCESS_MODE_INHERIT
	buttons[2].process_mode = Node.PROCESS_MODE_INHERIT
	buttons[3].process_mode = Node.PROCESS_MODE_INHERIT


#func all_in(button_index: int):
	#if buttons[4].is_pressed():
		#canvas_layers[3].hide()
	#if button_index == questions[current_question_index].correct_answer_index:
		#questions[current_question_index].correct_answer_index = questions[current_question_index].correct_answer_index
		#questions[current_question_index].score *= 4
		#next_question()
	#else:
		#heart_shake()
		#health -= 3
		#life()

#func double_down(button_index: int):
	#if buttons[5].is_pressed():
		#canvas_layers[3].hide()
	#if button_index == questions[current_question_index].correct_answer_index:
		#questions[current_question_index].correct_answer_index = questions[current_question_index].correct_answer_index
		#questions[current_question_index].score *= 2
		#health +=1
		#next_question()
	#else:
		#heart_shake()
		#health -= 2
		#life()

#func half_time(button_index: int):
	#if buttons[5].is_pressed():
		#canvas_layers[3].hide()
		#timers[0].stop()
		#timers[1].start()
	#if button_index == questions[current_question_index].correct_answer_index:
		#questions[current_question_index].correct_answer_index = questions[current_question_index].correct_answer_index
		#questions[current_question_index].score *= 1.5
		#next_question()
	#else:
		#heart_shake()
		#health -= 1
		#life()

func heart_shake():
	if health == 3:
		music.pitch_scale = 0.9
		animation_player_4.play("background")
		animation_player_3.play("heart_shake")
		animation_player.play("on_damage_1")
		animation_player_2.play("take damage")
	elif health == 2:
		music.pitch_scale = 1.0
		animation_player_4.play("background")
		animation_player_3.play("heart_shake_2")
		animation_player.play("on_damage_2")
		animation_player_2.play("take_damage_2")
	elif health == 1:
		music.pitch_scale = 1.2
		animation_player_4.play("background")
		animation_player_3.play("heart_shake_3")

func life():
	color_rect_show()
	if health == 3:
		health -= 1
		await get_tree().create_timer(3).timeout
		color_rect_hide()
		timers[0].paused = false
	elif health == 2:
		health -= 1
		await get_tree().create_timer(3).timeout
		color_rect_hide()
		timers[0].paused = false
	elif health == 1:
		health -=1
		await get_tree().create_timer(3).timeout
		color_rect_hide()
		timers[0].paused = false
	await get_tree().create_timer(1).timeout
	color_rect_hide()
	timers[0].paused = false
	print(health)
	if health <= 0:
		soul_claimed.text = "YOUR SOUL HAS BEEN CLAIMED"
		end_anims()
		canvas_layers[1].show()
		canvas_layers[2].hide()
		canvas_layers[0].hide()
		color_rect_hide()
		game_over_score.text = score_label.text + " Claimed"
		if questions_answered_correctly <= question_limit_index:
			questions_answered.text = "You answered: " + str(questions_answered_correctly) + " questions correctly"



func next_question():
	reset_button_process_mode()
	timers[0].paused = true
	score_label.text = str(questions[current_question_index].score) + " Souls"
	questions_answered_correctly += 1
	color_rect_show()
	current_question_index += 1
	_updateQuestion()
	_updateAnswer()

func _updateQuestion():
	timers[0].paused = true
	for question in questions:
		if current_question_index > questions.size() - 1:
			current_question_index = 0
			break#hack replace this line with survive condition.
		question_field.text = questions[current_question_index].question
		question_number.text = "Question: " + str(current_question_index + 1)
		question_value.text = "For " + str(questions[current_question_index].score) + " Souls"

func _updateAnswer():
	var index = 0
	correct_answer_index = questions[current_question_index].correct_answer_index
	for answer in questions[current_question_index].answers:
		#Loops through each answer of the current question.
		_button_alpha(index)
		_updateText(index, answer)
		index += 1

#hack this is required or the entire button appearing system below breaks
func _button_alpha(index):
	buttons[index].modulate.a = 0

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
	timers[0].paused = false

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

func end_anims():
	animation_player.stop()
	animation_player_2.stop()
	animation_player_3.stop()
	animation_player_4.stop()

func _updateQuestion_Timer():
	question_timer.text = str("Time: ") + "%.2f" % timers[0].time_left

func _on_answer_button_pressed() -> void:
	pressed(0)

func _on_answer_button_2_pressed() -> void:
	pressed(1)

func _on_answer_button_3_pressed() -> void:
	pressed(2)

func _on_answer_button_4_pressed() -> void:
	pressed(3)

#func _on_all_in_pressed() -> void:
	#canvas_layers[3].hide()
#
#func _on_double_down_pressed() -> void:
	#canvas_layers[3].hide()
#
#func _on_half_time_pressed() -> void:
	#canvas_layers[3].hide()
