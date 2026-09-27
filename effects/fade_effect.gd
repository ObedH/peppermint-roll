class_name FadeEffect
extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

var tween: Tween

func _ready() -> void:
	color_rect.modulate.a = 0


func fade(dest: Color, duration: float) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(color_rect, "modulate", dest, duration)
	await tween.finished
