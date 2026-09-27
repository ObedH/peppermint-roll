class_name Level
extends Node2D

var last_spawn_pos: Vector2

@onready var player: Player = $Player

func _ready() -> void:
	GameManager.checkpoint_entered.connect(_on_checkpoint_entered)


func reload_level() -> void:
	var tw: Tween = create_tween()
	tw.tween_property(player, "global_position", last_spawn_pos, 0.002 * last_spawn_pos.distance_to(player.global_position))
	player.reset()
	await tw.finished


func _on_checkpoint_entered(pos: Vector2) -> void:
	last_spawn_pos = pos


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("hello!")
	if body is Player:
		get_tree().change_scene_to_file.call_deferred("res://scenes/you_win.tscn")
