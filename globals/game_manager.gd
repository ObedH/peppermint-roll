extends Node

signal health_changed(new_val: float)


func change_health(new_val: float) -> void:
	health_changed.emit(new_val)
