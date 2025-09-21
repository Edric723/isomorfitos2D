class_name Efectividades

# Diccionario de efectividades: (atacante, defensor) -> multiplicador
const efectividad := {
	# SOLAR
	["Solar", "Aqua"]: 0.0,
	["Normal", "Fantasma"]: 0.0,

	# UMBRA
	["Fuego", "Planta"]: 2.0,
	["Fuego", "Hielo"]: 2.0,
	["Fuego", "Bicho"]: 2.0,

	["Fuego", "Fuego"]: 0.5,
	["Fuego", "Agua"]: 0.5,
	["Fuego", "Roca"]: 0.5,
	["Fuego", "Dragon"]: 0.5,

	# AQUA
	["Agua", "Fuego"]: 2.0,
	["Agua", "Tierra"]: 2.0,
	["Agua", "Roca"]: 2.0,

	["Agua", "Agua"]: 0.5,
	["Agua", "Planta"]: 0.5,
	["Agua", "Dragon"]: 0.5,

	# FUNGI
	["Electrico", "Agua"]: 2.0,
	["Electrico", "Volador"]: 2.0,

	["Electrico", "Electrico"]: 0.5,
	["Electrico", "Planta"]: 0.5,
	["Electrico", "Dragon"]: 0.5,

	["Electrico", "Tierra"]: 0.0,

	# CRISTAGENA
	["Planta", "Agua"]: 2.0,
	["Planta", "Tierra"]: 2.0,
	["Planta", "Roca"]: 2.0,

	["Planta", "Fuego"]: 0.5,
	["Planta", "Planta"]: 0.5,
	["Planta", "Veneno"]: 0.5,
	["Planta", "Volador"]: 0.5,
	["Planta", "Bicho"]: 0.5,
	["Planta", "Dragon"]: 0.5,

	# LIGNEN
	["Hielo", "Planta"]: 2.0,
	["Hielo", "Tierra"]: 2.0,
	["Hielo", "Volador"]: 2.0,
	["Hielo", "Dragon"]: 2.0
	
	}

#Método para obtener la efectividad de un movimiento entre un tipo de morfito contra el tipo de otro morfito.
static func obtener_efectividad(atq_tipo: String, def_tipo: String) -> float:
	return efectividad.get([atq_tipo, def_tipo], 1.0)
