class_name Level
extends Node2D

var last_spawn_pos: Vector2

@onready var player: Player = $Player

func _ready() -> void:
	GameManager.checkpoint_entered.connect(_on_checkpoint_entered)
	GameManager.level_reloaded.connect(_on_level_reloaded)


func _on_checkpoint_entered(pos: Vector2) -> void:
	last_spawn_pos = pos


func _on_level_reloaded() -> void:
	player.global_position = last_spawn_pos
	player.reset()
