# --- Movimiento.gd ---
class_name Movimiento

var mov_nombre: String
var mov_tipo: String
var categoria: String
var poder: int
var punteria: int


func _init(movNombre: String, movTipo: String, tipoAtq: String, fuerza: int, acierto: int) -> void:
	self.mov_nombre = movNombre
	self.mov_tipo = movTipo
	self.categoria = tipoAtq
	self.poder = fuerza
	self.punteria = acierto
