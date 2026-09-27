extends Control

var time: float

@onready var timre: Label = $Timre


func _process(delta: float):
	time += delta
	timre.text = "Time: %.3f" % time
	GameManager.time = time
