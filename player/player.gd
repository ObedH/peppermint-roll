class_name Player
extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 2000
const FALL_GRAVITY_MULT = 1.4
const FINISH_UP_JUMP_MULT = 2
const FRICTION = 800
const ACCELERATION = 500
const MAX_HEALTH = 1

var health: float
var input_locked: bool = false
var is_taking_damage: bool = false
var jump_buffer: bool = false
var is_finishing_up_jump: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_timer: Timer = $DeathTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer


func _ready() -> void:
	health = MAX_HEALTH
	GameManager.change_health(1)
	GameManager.player = self


func reset() -> void:
	velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if velocity.y < 0:
			if is_finishing_up_jump:
				velocity += Vector2.DOWN * GRAVITY * FINISH_UP_JUMP_MULT * delta
			else:
				velocity += Vector2.DOWN * GRAVITY * delta
		elif velocity.y >= 0:
			velocity += Vector2.DOWN * GRAVITY * FALL_GRAVITY_MULT * delta
			is_finishing_up_jump = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer = true
		jump_buffer_timer.start()
	
	if jump_buffer and is_on_floor() and not input_locked:
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("ui_accept"):
		is_finishing_up_jump = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and not input_locked:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	move_and_slide()
	
	if velocity.x > 0.0001:
		sprite.flip_h = false
	elif velocity.x < 0.0001:
		sprite.flip_h = true
	
	if not is_taking_damage:
		if abs(velocity.x) < 0.0001:
			sprite.play("default")
		else:
			sprite.play("roll")


func _on_hurt_box_body_entered(body: Node2D) -> void:
	take_hit(body is TileMapLayer)


func _on_hurt_box_area_entered(area: Area2D) -> void:
	take_hit(false)


func take_hit(is_tilemaplayer: bool) -> void:
	health -= 0.3
	sprite.play("damage")
	is_taking_damage = true
	death_timer.start()
	if is_tilemaplayer:
		GameManager.change_health(health)
		GameManager.reload_level()
	else:
		GameManager.change_health(health)
		velocity.y = JUMP_VELOCITY
	if health <= 0:
		get_tree().change_scene_to_file.call_deferred("res://scenes/gameover.tscn")


func _on_death_timer_timeout() -> void:
	is_taking_damage = false
	sprite.play("default")


func _on_jump_buffer_timer_timeout() -> void:
	jump_buffer = false
