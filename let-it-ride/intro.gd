extends Control

func _ready():
	# Iniciamos el temporizador al entrar en la escena
	$Timer.start()

func _on_timer_timeout():
	# Cuando pasan los segundos, cambiamos al menú principal
	get_tree().change_scene_to_file("res://menu_in_game.tscn")
