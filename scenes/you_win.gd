extends Control

@onready var label_2: Label = $Label2
@onready var label_3: Label = $Label3
@onready var button: Button = $Button

func _ready() -> void:
	button.grab_focus()
	if GameManager.time < GameManager.best:
		GameManager.best = GameManager.time
		label_2.label_settings.font_color = Color.GOLD
		var sf: SaveFile = SaveFile.new()
		sf.best_time = GameManager.best
		ResourceSaver.save(sf, "user://highscore.tres")
		
	label_2.text = "Time: %.3f" % GameManager.time
	label_3.text = "Best: %.3f" % GameManager.best
	var tw: Tween = create_tween()
	tw.tween_property(label_2, "offset_transform_scale", Vector2(1.2, 1.2), 0.25)
	tw.tween_property(label_2, "offset_transform_scale", Vector2(1, 1), 0.25)
	tw.set_loops()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
