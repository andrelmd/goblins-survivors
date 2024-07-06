extends Node

var elapsed_time = 0

signal time_changed

func _ready():
	start_timeout()

func start_timeout():
	get_tree().create_timer(1).timeout.connect(_on_timeout)

func _on_timeout():
	elapsed_time += 1
	time_changed.emit()
	start_timeout()
