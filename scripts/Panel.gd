extends Panel

@onready var time_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer

const TIME_BONUS: float = 25.0
const TIME_LOST: float = 2.0

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

func check_answer():
	var ip_card = Global.input_card
	
	if ip_card.contains(results[current_index]):
		Global.progress += 10
		add_time_bonus()
		print("Correct:", Global.progress, "Timer:", timer.time_left)
	else:
		Global.progress -= 10
		remove_time_bonus()
		print("Wrong:", Global.progress)
		if Global.progress <= 0 || timer.timeout:
			get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
	get_clue()

func add_time_bonus():
	time_bar.value += TIME_BONUS
	time_bar.value = clamp(time_bar.value, time_bar.min_value, time_bar.max_value)
	
func remove_time_bonus():
	time_bar.value -= TIME_LOST
	time_bar.value = clamp(time_bar.value, time_bar.min_value, time_bar.max_value)

func _ready():
	time_bar.value = time_bar.max_value
	randomize()
	get_clue()

func check_time():
	if timer.timeout:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
