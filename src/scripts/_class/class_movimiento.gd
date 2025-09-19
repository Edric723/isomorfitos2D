class_name Movimiento

var mov_nombre: String
var mov_tipo: String
var categoria: String
var poder: int
var punteria: int

func _init(mov_nombre: String, mov_tipo: String, categoria: String, poder: int, punteria: int) -> void:
	self.mov_nombre = mov_nombre
	self.mov_tipo = mov_tipo
	self.categoria = categoria
	self.poder = poder
	self.punteria = punteria
