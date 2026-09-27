extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var button: Button = $Button
@onready var label_2: Label = $AnimatedSprite2D/Label2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.grab_focus()
	animation_player.play("new_animation")
	animated_sprite_2d.play("default")
	if GameManager.best != 999999999999999:
		label_2.text = "Best Time: %.3f" % GameManager.best
		label_2.label_settings.font_color = Color.GOLD
	else:
		label_2.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/play.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit(0)
