extends Panel

@onready var time_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer

const TIME_BONUS: float = 2.0
const TIME_LOST: float = 5.0

var clues = [
	"veggie bowl",
	"island money",
	"big red ball",
	"buy in bulk",
	"strrrrrrrrrrrrrrrrrrrike!"
]

var results = [
	"%B6010563596189797^CHIPOTLE",
	"%B4859530006682470^",
	"",
	"%7001112034796255^",
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
		print("Correct:", Global.progress)
		print(timer.time_left)
	else:
		Global.progress -= 10
		remove_time_bonus()
		print("Wrong:", Global.progress)
		print(timer.time_left)
		if Global.progress <= 0:
			get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
	get_clue()

func add_time_bonus():
	var left = timer.time_left
	timer.start(left + TIME_BONUS)
	
func remove_time_bonus():
	var left = timer.time_left
	timer.start(left - TIME_LOST)

func _ready():
	time_bar.value = time_bar.max_value
	randomize()
	get_clue()

func _process(delta: float):
	time_bar.value = clamp(timer.time_left, time_bar.min_value, time_bar.max_value)

func check_time():
	if timer.timeout:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/level2.tscn")
