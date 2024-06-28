extends Node2D
@onready var music: AudioStreamPlayer = $Music
func _ready() -> void:
	music.play(0.0)
	$StartGame.text = "Start Game"
	$ExitGame.text = "Exit Game"


func _on_answer_button_pressed() -> void:
	get_tree().quit()


func _on_answer_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Trivia/Trivia.tscn")



	print_rich("[tornado][b][font=Font/BaroqueTextJF Regular.ttf][center]",
				"Timed In ","The Dark ",
				"[/center][/font][/b][/tornado]")
