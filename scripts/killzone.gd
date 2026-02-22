extends Area2D

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _on_body_entered(body):
	if body.name == "heidi":
		Global.who_died = "heidi"
	elif body.name == "orpheus":
		Global.who_died = "orpheus"
	print(body.name + "died")
	timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
