# --- Movimiento.gd ---
class_name Movimiento

var mov_nombre: String
var mov_tipo: String
var categoria: String
var poder: int
var punteria: int

# Aliases para compatibilidad (tu lógica usa mov.nombre y mov.tipo)
var nombre: String:
	get: return mov_nombre
	set(value): mov_nombre = value

var tipo: String:
	get: return mov_tipo
	set(value): mov_tipo = value

func _init(mov_nombre: String, mov_tipo: String, categoria: String, poder: int, punteria: int) -> void:
	self.mov_nombre = mov_nombre
	self.mov_tipo = mov_tipo
	self.categoria = categoria
	self.poder = poder
	self.punteria = punteria
