extends Node2D
@onready var music: AudioStreamPlayer = $Music
func _ready() -> void:
	music.play(0.0)
	$AnswerButton2.text = "Start Game"
	$AnswerButton.text = "Exit Game"


func _on_answer_button_pressed() -> void:
	get_tree().quit()


func _on_answer_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Trivia/Trivia.tscn")

