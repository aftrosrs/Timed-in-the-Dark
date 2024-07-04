extends CanvasLayer



func _ready() -> void:
	$MarginContainer2/VBoxContainer/AnswerButton3.text = String("M a i n  M e n u")
	$MarginContainer2/VBoxContainer/AnswerButton.text = String("R e s t a r t  G a m e")
	$MarginContainer2/VBoxContainer/AnswerButton2.text = String("E x i t  G a m e")



func _on_answer_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_answer_button_2_pressed() -> void:
	get_tree().quit()


func _on_answer_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/main_menu.tscn")
