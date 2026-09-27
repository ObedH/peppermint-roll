class_name Pla
extends Node2D

@onready var level_base: Level = $LevelBase
@onready var fade_effect: FadeEffect = $FadeEffect


func _ready() -> void:
	GameManager.level_reloaded.connect(_on_level_reloaded)


func _on_level_reloaded():
	GameManager.player.input_locked = true
	#await fade_effect.fade(Color.BLACK, 0.2)
	await level_base.reload_level()
	#await fade_effect.fade(Color.TRANSPARENT, 0.2)
	GameManager.player.input_locked = false
	GameManager.player.is_taking_damage = false
