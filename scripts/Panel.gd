extends Panel

var clues = [
	"veggie bowl",
	"island money",
	"big red ball",
	"buy in bulk",
	"strrrrrrrrrrrrrrrrrrrike!"
]

var results = [
	"%B6010563596189797^CHIPOTLE",
	"%B4859530006682470^EGAN/SOFIA",
	"",
	"%7001112034796255^BOORGU/MANITEJ",
	"%6686=6673103695066313650?"
]

var current_index : int

@onready var clue_label = $ClueLabel

func get_clue():
	current_index = randi() % clues.size()
	clue_label.text = clues[current_index]
	print(results[current_index])

func check_answer():
	var ip_card = Global.input_card
	
	if ip_card.contains(results[current_index]):
		Global.progress += 10
		print("Correct:", Global.progress)
	else:
		Global.progress -= 10
		print("Wrong:", Global.progress)
		if Global.progress <= 0:
			get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
	get_clue()


func _ready():
	randomize()
	get_clue()
