class_name Entrenador

var entrenador_nombre: String
var morfitos: Array
 
func _init(entrenador_nombre: String, morfitos: Array = []) -> void:
	self.entrenador_nombre = entrenador_nombre
	self.morfitos= morfitos
