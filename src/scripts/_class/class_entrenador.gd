# Entrenador.gd
class_name Entrenador

var entrenador_nombre: String
var morfitos: Array

# Alias para compatibilidad con funciones que leen t.morfis
var morfis: Array:
	get: return morfitos
	set(value): morfitos = value

func _init(entrenador_nombre: String, morfitos: Array = []) -> void:
	self.entrenador_nombre = entrenador_nombre
	self.morfitos = morfitos
