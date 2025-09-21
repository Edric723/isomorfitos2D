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


func _init(morfito_nombre: String, morfito_tipo: String, atq: int, def: int, atqEsp: int, defEsp: int, ps: int, psMax: int, velocidad: int, movimientos: Array) -> void:
	self.morfito_nombre = morfito_nombre
	self.morfito_tipo = morfito_tipo
	self.atq = atq
	self.def = def
	self.atq_esp = atq_esp
	self.def_esp = def_esp
	self.ps = ps
	self.ps_max = ps_max
	self.velocidad = velocidad
	self.movimientos = movimientos
