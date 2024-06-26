extends CanvasLayer


func _ready() -> void:
	$MarginContainer2/VBoxContainer/HBoxContainer/AnswerButton.text = String("Restart game")





func _on_answer_button_pressed() -> void:
	get_tree().reload_current_scene()
