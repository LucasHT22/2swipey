extends Node2D

func _ready() -> void:
	$Panel2.visible = false
	if Global.who_died == "heidi":
		$Panel1/heidiscreen.visible = true
		$Panel1/orpheusscreen.visible = false
		
	elif Global.who_died == "orpheus":
		$Panel1/orpheusscreen.visible = true
		$Panel1/heidiscreen.visible = false

func _on_timer_timeout() -> void:
	$Panel1.visible = false
	$Panel2.visible = true
	$Panel2/Text1.visible = true
	$Panel2/endingaud1.play()
	await $Panel2/endingaud1.finished
	await get_tree().create_timer(1.0).timeout
	$Panel2/Text2.visible = true
	$Panel2/endingaud2.play()
	await $Panel2/endingaud2.finished
	await get_tree().create_timer(2.0).timeout
	$Panel2/Text3.visible = true
	
