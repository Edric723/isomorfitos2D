class_name Morfito

var morfito_nombre: String
var morfito_tipo: String
var atq: int
var def: int
var atqEsp: int
var defEsp: int
var ps: int
var psMax: int
var velocidad: int
var movimientos: Array = []


func _init(morfito_nombre: String, morfito_tipo: String, atq: int, def: int, atqEsp: int, defEsp: int, ps: int, psMax: int, velocidad: int, movimientos: Array) -> void:
	self.morfito_nombre = morfito_nombre
	self.morfito_tipo = morfito_tipo
	self.atq = atq
	self.def = def
	self.atqEsp = atqEsp
	self.defEsp = defEsp
	self.ps = ps
	self.psMax = psMax
	self.velocidad = velocidad
	self.movimientos = movimientos
