extends CanvasLayer



func _ready() -> void:
	$MarginContainer2/VBoxContainer/AnswerButton3.text = String("Main Menu")
	$MarginContainer2/VBoxContainer/AnswerButton.text = String("Restart Game")
	$MarginContainer2/VBoxContainer/AnswerButton2.text = String("Exit Game")



func _on_answer_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_answer_button_2_pressed() -> void:
	get_tree().quit()


func _on_answer_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/main_menu.tscn")
