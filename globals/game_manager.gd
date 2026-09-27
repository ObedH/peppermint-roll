extends Node

signal health_changed(new_val: float)
signal checkpoint_entered(pos: Vector2)
signal level_reloaded()

var player: Player


func change_health(new_val: float) -> void:
	health_changed.emit(new_val)


func enter_checkpoint(pos: Vector2) -> void:
	checkpoint_entered.emit(pos)

func reload_level() -> void:
	level_reloaded.emit()


func hitstop() -> void:
	get_tree().paused = true
	await get_tree().create_timer(0.02, true, true, true).timeout
	get_tree().paused = false
