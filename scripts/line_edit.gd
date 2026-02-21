extends LineEdit

func _ready():
	grab_focus()

func _on_text_submitted(new_text: String) -> void:
	prints(new_text)
	clear()
