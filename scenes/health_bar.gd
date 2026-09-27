class_name HealthBar
extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.health_changed.connect(_on_health_changed)


func _on_health_changed(new_val: float) -> void:
	value = new_val * 100
