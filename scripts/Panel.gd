extends Panel

@onready var time_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer
@onready var feedback_accept: Sprite2D = $Accept
@onready var feedback_decline: Sprite2D = $Decline
@onready var feedback_accept_sound: AudioStreamPlayer = $Accepted_sound
@onready var feedback_decline_sound: AudioStreamPlayer = $Declined_sound
@onready var safe_sprite: AnimatedSprite2D = $safe

const TIME_BONUS: float = 20.0
const TIME_LOST: float = 5.0

var clues = [
	"burrito bowl",
	"island money",
	"buy in bulk",
	"strrrrrrrrrrrrrrrrrrrike!",
	"merchant joseph",
	"public transport",
	"passport"
]

var results = [
	"%B6010563596189797^CHIPOTLE",
	"%B4859530006682470^",
	"%7001112034796255^",
	"%6686=6673103695066313650?",
	"%B5896295042795981",
	"%B6398840026017826281^07675055494$01500",
	"%B4097581493304310^A GIFT FOR YOU^"
]

var current_index : int

@onready var clue_label = $ClueLabel

func get_clue():
	if Global.progress > 60:
		get_tree().change_scene_to_file("res://scenes/level2.tscn")
	else:
		current_index = randi() % clues.size()
		clue_label.text = clues[current_index]

func check_answer():
	var ip_card = Global.input_card
	
	if ip_card.contains(results[current_index]):
		Global.progress += 10
		add_time_bonus()
		feedback_accept.visible = true
		feedback_accept_sound.play()
		await get_tree().create_timer(1.0).timeout
		feedback_accept.visible = false
		print("Correct:", Global.progress)
		print(timer.time_left)
		
	else:
		Global.progress -= 10
		remove_time_bonus()
		feedback_decline.visible = true
		feedback_decline_sound.play()
		shake_safe()
		await get_tree().create_timer(1.0).timeout
		feedback_decline.visible = false
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
	
func shake_safe():
	var original_pos = safe_sprite.position
	var tween = create_tween()
	tween.tween_property(safe_sprite, "position", original_pos + Vector2(10, 0), 0.05)
	tween.tween_property(safe_sprite, "position", original_pos + Vector2(-10, 0), 0.05)
	tween.tween_property(safe_sprite, "position", original_pos + Vector2(8, 0), 0.05)
	tween.tween_property(safe_sprite, "position", original_pos + Vector2(-8, 0), 0.05)
	tween.tween_property(safe_sprite, "position", original_pos, 0.05)
