extends LineEdit

func _ready():
	grab_focus()

func _on_text_submitted(new_text: String) -> void:
	Global.input_card = new_text
	print(Global.input_card)
	
	var panel = get_node("/root/TipsMenu/Background/MarginContainer/Panel")
	panel.check_answer()
	clear()
