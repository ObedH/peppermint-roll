class_name Player
extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 2000
const FRICTION = 800
const ACCELERATION = 500
const MAX_HEALTH = 100

var health: float

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	health = MAX_HEALTH

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += Vector2.DOWN * GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	move_and_slide()
	
	if velocity.x > 0.0001:
		sprite.flip_h = false
	elif velocity.x < 0.0001:
		sprite.flip_h = true
	
	if abs(velocity.x) < 0.0001:
		sprite.play("default")
	else:
		sprite.play("roll")


func _on_hurt_box_body_entered(body: Node2D) -> void:
	health -= 10
	if health < 0:
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")
