extends Control

func _ready():
	# Animacion de entrada
	$AnimationPlayer.play("intro_menu")

func _on_boton_jugar_pressed():
	# Cambia a "res://Ruleta.tscn" 
	get_tree().change_scene_to_file("res://Ruleta.tscn")

func _on_boton_salir_pressed():
	# Sale del juego
	get_tree().quit()
