extends LineEdit

@onready var heidi = get_node("/root/Level2/heidi")
@onready var orpheus = get_node("/root/Level2/orpheus")

const playercards = [
	";3106080019916304577?",
	";3106080048216304567?"
]

func _ready():
	grab_focus()

func _on_text_submitted(new_text: String) -> void:
	Global.input_card = new_text
	print(Global.input_card)
	check_card()

	clear()

func check_card():
	var ip_card = Global.input_card
	
	if ip_card.contains(playercards[0]):
		orpheus.attack()
	elif ip_card.contains(playercards[1]):
		heidi.attack()
		
