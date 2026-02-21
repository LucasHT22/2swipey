extends Area2D

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _on_body_entered(body):
	print("died")
	timer.start()
	
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/tips_menu.tscn")
