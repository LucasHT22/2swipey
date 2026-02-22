extends Node2D

func _ready() -> void:
	$Background/Label/AnimationPlayer.play("boh")
	$Background/VBoxContainer/AnimationPlayer.play("si")



func _on_start_gui_input(event: InputEvent) -> void:
	get_tree().change_scene_to_file("res://scenes/tips_menu.tscn")


func _on_line_edit_gui_input(event: InputEvent) -> void:
	get_tree().change_scene_to_file("res://scenes/tips_menu.tscn")
