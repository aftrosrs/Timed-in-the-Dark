extends Control




func _ready() -> void:
	$CanvasLayer/MarginContainer2/VBoxContainer/HBoxContainer/Button.text = String("Restart game")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Trivia/Trivia.tscn")

