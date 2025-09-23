class_name Efectividades

# Diccionario de efectividades: (atacante, defensor) -> multiplicador
const efectividad := {
	# SOLAR
	["Solar", "Aqua"]: 2.0,
	["Solar", "Umbra"]: 2.0,
	["Solar", "Fungi"]: 0.5,
	["Solar", "Cristagena"]: 0.5,
	["Solar", "Lignen"]: 1.0,

	# UMBRA (Fuego)
	["Umbra", "Cristagena"]: 2.0,
	["Umbra", "Lignen"]: 2.0,
	["Umbra", "Solar"]: 0.5,
	["Umbra", "Aqua"]: 0.5,
	["Umbra", "Umbra"]: 0.5,

	# AQUA (Agua)
	["Aqua", "Umbra"]: 2.0,
	["Aqua", "Lignen"]: 2.0,
	["Aqua", "Solar"]: 0.5,
	["Aqua", "Cristagena"]: 0.5,
	["Aqua", "Aqua"]: 0.5,

	# FUNGI (Fungica)
	["Fungi", "Aqua"]: 2.0,
	["Fungi", "Lignen"]: 1.0,
	["Fungi", "Cristagena"]: 0.5,
	["Fungi", "Solar"]: 1.0,
	["Fungi", "Fungi"]: 0.5,

	# CRISTAGENA (Planta)
	["Cristagena", "Aqua"]: 2.0,
	["Cristagena", "Lignen"]: 0.5,
	["Cristagena", "Solar"]: 2.0,
	["Cristagena", "Umbra"]: 0.5,
	["Cristagena", "Cristagena"]: 0.5,

	# LIGNEN (Hielo)
	["Lignen", "Cristagena"]: 2.0,
	["Lignen", "Solar"]: 2.0,
	["Lignen", "Umbra"]: 1.0,
	["Lignen", "Aqua"]: 0.5,
	["Lignen", "Lignen"]: 0.5
}

# Método para obtener la efectividad
static func obtener_efectividad(atq_tipo: String, def_tipo: String) -> float:
	return efectividad.get([atq_tipo, def_tipo], 1.0)
