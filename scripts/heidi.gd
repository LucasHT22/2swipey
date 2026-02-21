extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var is_attacking = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var animated_player = $AnimationPlayer
@onready var hitbox = $hit/CollisionShape2D

var knockback = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump_p2") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left_p2", "move_right_p2")

	if direction < 0:
		animated_sprite.flip_h = true
		hitbox.position.x = -abs(hitbox.position.x)
	elif direction > 0:
		animated_sprite.flip_h = false
		hitbox.position.x = abs(hitbox.position.x)

	if is_on_floor() and not(is_attacking):
		animated_sprite.play("default")
	elif not(is_attacking):
		animated_sprite.play("jump")

	if knockback != Vector2.ZERO:
		velocity = knockback
		knockback = knockback.move_toward(Vector2.ZERO, SPEED * delta * 10)
	elif direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("attack_temp_p2"):
		attack()

	move_and_slide()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.get_parent() != self:
		print("heidi was attacked")
		var dir = sign(self.position.x - area.get_parent().position.x)
		knockback = Vector2(dir * SPEED * 2, randi_range(-400,-200))

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		is_attacking = false
		
func attack():
	is_attacking = true
	animated_player.play("attack")
	
