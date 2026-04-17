extends Node2D

@onready var bolita_pivote = $OrbitadorBola 
@onready var detector_bola = $OrbitadorBola/SpriteBola/DetectorBola 

@onready var label_resultado = $Label
@onready var input_apuesta = $LineEdit

var girando = false
var velocidad = 0.0

func _on_button_pressed():
	if girando: return
	
	if input_apuesta.text == "":
		label_resultado.text = "Escribe un numero"
		return
		
	# Iniciamos el giro
	bolita_pivote.rotation_degrees = randf_range(0, 360)
	
	girando = true
	velocidad = randf_range(1200.0, 1800.0) 
	label_resultado.text = "Girando!"

func _process(delta):
	if girando:
	# Giramos la bola
		bolita_pivote.rotation_degrees += velocidad * delta
		
		$OrbitadorBola/SpriteBola.rotation_degrees -= velocidad * delta * 2
		
		velocidad *= 0.985
		
		# Si va lento, se detiene
		if velocidad < 10.0: 
			detener_bola()

func detener_bola():
	girando = false
	velocidad = 0
	
	await get_tree().physics_frame
	
	# Obtenemos todas las areas que estan tocando el detector de la bola
	var areas_superpuestas = detector_bola.get_overlapping_areas()
	
	var resultado = "N/A" # Por si acaso no detecta nada
	
	# Buscamos cual de esas areas es un sensor de numero usando Metadata
	for area in areas_superpuestas:
		if area.is_in_group("sensores_ruleta"):
			if area.has_meta("numero_ruleta"):
				resultado = str(area.get_meta("numero_ruleta"))
				break 
	
	if resultado == "N/A":
		label_resultado.text = "Error de deteccion. Intenta de nuevo."
		return

	if resultado == input_apuesta.text:
		label_resultado.text = "GANASTE! Salio el " + resultado
	else:
		label_resultado.text = "Perdiste. Salio el " + resultado
