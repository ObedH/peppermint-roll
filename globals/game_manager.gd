extends Node

signal health_changed(new_val: float)
signal checkpoint_entered(pos: Vector2)
signal level_reloaded()


func change_health(new_val: float) -> void:
	health_changed.emit(new_val)


func enter_checkpoint(pos: Vector2) -> void:
	checkpoint_entered.emit(pos)

func reload_level() -> void:
	level_reloaded.emit()
