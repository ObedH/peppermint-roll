extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 9000

var movement_direction: float = -1

@onready var floorcaster: RayCast2D = $Floorcaster
@onready var wallcaster: RayCast2D = $WallCaster
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	sprite.play("walk")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if floorcaster.is_colliding() and not wallcaster.is_colliding():
		velocity.x = move_toward(velocity.x, SPEED * movement_direction, ACCELERATION * delta)
	else:
		movement_direction *= -1
		floorcaster.position.x *= -1
		wallcaster.position.x *= -1
		wallcaster.target_position.x *= -1
	
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false

	move_and_slide()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	GameManager.hitstop()
	GameManager.player.velocity.y = JUMP_VELOCITY
	queue_free()
