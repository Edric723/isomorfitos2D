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

func _init(nombre: String, tipo: String, ataque: int, defensa: int, atqEsp: int, defEsp: int, vida: int, vidaMax: int, rapidez: int, ataques: Array) -> void:
	self.morfito_nombre = nombre
	self.morfito_tipo = tipo
	self.atq = ataque
	self.def = defensa
	self.atq_esp = atqEsp     # <-- usar el parámetro
	self.def_esp = defEsp     # <-- usar el parámetro
	self.ps = vida
	self.ps_max = vidaMax       # <-- usar el parámetro
	self.velocidad = rapidez
	self.movimientos = ataques
