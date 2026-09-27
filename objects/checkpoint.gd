class_name Checkpoint
extends Area2D

@export var idx: int

@onready var spawn_pos: Marker2D = $Marker2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.enter_checkpoint(spawn_pos.global_position)
