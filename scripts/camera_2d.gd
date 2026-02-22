extends Camera2D

@export var orpheus: CharacterBody2D
@export var heidi: CharacterBody2D
const CAMERA_SPEED = 5.0 # Adjust the speed of the camera movement

func _ready():
	self.limit_top = -450
	
func _process(delta: float):
	if orpheus and heidi:
		var midpoint = (orpheus.global_position + heidi.global_position) / 2.0
		global_position = midpoint
