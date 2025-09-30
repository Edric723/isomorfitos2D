# Entrenador.gd
class_name Entrenador

var entrenador_nombre: String
var morfitos: Array

func _init(entrenadorNombre: String, equipo: Array = []) -> void:
	self.entrenador_nombre = entrenadorNombre
	self.morfitos = equipo
