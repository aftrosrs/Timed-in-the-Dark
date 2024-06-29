extends Node2D
@onready var music: AudioStreamPlayer = $Music
@onready var animation_player: AnimationPlayer = $Eye/AnimationPlayer

func _ready() -> void:
	music.play(0.0)
	$StartGame.text = "Start Game"
	$ExitGame.text = "Exit Game"
	animation_player.play("Zoom in")

	print_rich("[tornado][b][font=Font/BaroqueTextJF Regular.ttf][center]",
				"Timed In ","The Dark ",
				"[/center][/font][/b][/tornado]")

	print_rich("[wave][b][font=Font/BaroqueTextJF Regular.ttf][center]",
				"Created ","By ",
				"[/center][/font][/b][/wave]")

	print_rich("[wave][pulse][b][font=Font/BaroqueTextJF Regular.ttf][center]",
				"Music & Artist: ","Amythyst Morris",
				"[/center][/font][/b][/pulse][/wave]")

	print_rich("[pulse][wave][b][font=Font/BaroqueTextJF Regular.ttf][center]",
				"Developer: ","ThaAftrPartie ",
				"[/center][/font][/b][/wave][/pulse]")

func _on_answer_button_pressed() -> void:
	get_tree().quit()


func _on_answer_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Trivia/Trivia.tscn")







func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("Look around")
