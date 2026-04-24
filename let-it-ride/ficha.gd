extends Area2D

var arrastrando = false
var escala_original = Vector2(1.0, 1.0)
var escala_agrandada = Vector2(5, 5) # Se agranda el sprite al agarrarla

@onready var sprite_sombra = $Sombra

func _ready():
	escala_original = scale
	if sprite_sombra:
		sprite_sombra.visible = false

func _input_event(viewport, event, shape_idx):
	# Detecta el click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			arrastrando = true
			scale = escala_agrandada # Efecto de agrandar
			z_index = 10 
			
			# Mostrar sombra
			if sprite_sombra:
				sprite_sombra.visible = true
				sprite_sombra.position = Vector2(2, 2) # Desplazamiento de la sombra
		else:
			arrastrando = false
			scale = escala_original 
			z_index = 0
			
			# Ocultar sombra
			if sprite_sombra:
				sprite_sombra.visible = false
				sprite_sombra.position = Vector2(0, 0)

func _process(delta):
	if arrastrando:
		# Mueve la ficha a la posicion del mouse
		global_position = get_global_mouse_position()
