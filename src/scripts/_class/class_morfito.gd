# --- Morfito.gd ---
class_name Morfito

var morfito_nombre: String
var morfito_tipo: String
var atq: int
var def: int
var atq_esp: int
var def_esp: int
var ps: int
var ps_max: int
var velocidad: int
var movimientos: Array = []

# Aliases para compatibilidad (tu lógica usa morfi.nombre y morfi.tipo)
var nombre: String:
	get: return morfito_nombre
	set(value): morfito_nombre = value

var tipo: String:
	get: return morfito_tipo
	set(value): morfito_tipo = value


func _init(morfito_nombre: String, morfito_tipo: String, atq: int, def: int, atqEsp: int, defEsp: int, ps: int, psMax: int, velocidad: int, movimientos: Array) -> void:
	self.morfito_nombre = morfito_nombre
	self.morfito_tipo = morfito_tipo
	self.atq = atq
	self.def = def
	self.atq_esp = atqEsp     # <-- usar el parámetro
	self.def_esp = defEsp     # <-- usar el parámetro
	self.ps = ps
	self.ps_max = psMax       # <-- usar el parámetro
	self.velocidad = velocidad
	self.movimientos = movimientos
