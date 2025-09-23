extends Node2D

func _ready():
	randomize()
	var combate := Combate.new()

	# Movimientos
	var mov_umbra := Movimiento.new("Ascuas", "Umbra", "Especial", 40, 95)
	var mov_aqua  := Movimiento.new("Pistola Agua", "Aqua", "Especial", 40, 100)

	# Morfitos
	var m1 := Morfito.new("Blazito","Umbra",10,7,12,6,60,60,9,[mov_umbra])
	var m2 := Morfito.new("Aquita","Aqua", 9,8,11,7,60,60,9,[mov_aqua])

	# Entrenadores (solo para saber si se acabó el equipo)
	var t1 := Entrenador.new("Rojo", [m1])
	var t2 := Entrenador.new("Azul", [m2])

	var turno := 1
	while not combate.tiene_equipo_debilitado(t1.morfis) and not combate.tiene_equipo_debilitado(t2.morfis):
		print("\n-- Turno %d --" % turno)

		# Elegimos movimientos (único por ahora)
		var mov1: Movimiento = m1.movimientos[0] as Movimiento
		var mov2: Movimiento = m2.movimientos[0] as Movimiento

		# Orden real del turno
		var primero: Morfito = combate.definir_primer_golpe(m1, m2)
		var segundo: Morfito = (m2 if primero == m1 else m1)
		var mov_primero: Movimiento = (mov1 if primero == m1 else mov2)
		var mov_segundo: Movimiento = (mov1 if segundo == m1 else mov2)

		print("Ataca primero: %s" % primero.morfito_nombre)

		# ---- Golpe 1 (solo prints + efecto real en PS) ----
		var hit1: bool = combate.acierta_Ataque(mov_primero)
		if hit1:
			var dmg1: int = int(round(combate.calcular_Danio(mov_primero, primero, segundo)))
			var mult1: float = Efectividades.obtener_efectividad(mov_primero.mov_tipo, segundo.morfito_tipo) # solo para mostrar
			segundo.ps = max(0, segundo.ps - dmg1)
			print("%s usó %s → daño %d (x%.2f). %s: %d/%d"
				% [primero.morfito_nombre, mov_primero.mov_nombre, dmg1, mult1, segundo.morfito_nombre, segundo.ps, segundo.ps_max])
		else:
			print("%s falló %s" % [primero.morfito_nombre, mov_primero.mov_nombre])

		if combate.esta_debilitado(segundo):
			print("%s quedó KO" % segundo.morfito_nombre)
			break

		# ---- Golpe 2 ----
		var hit2: bool = combate.acierta_Ataque(mov_segundo)
		if hit2:
			var dmg2: int = int(round(combate.calcular_Danio(mov_segundo, segundo, primero)))
			var mult2: float = Efectividades.obtener_efectividad(mov_segundo.mov_tipo, primero.morfito_tipo)
			primero.ps = max(0, primero.ps - dmg2)
			print("%s usó %s → daño %d (x%.2f). %s: %d/%d"
				% [segundo.morfito_nombre, mov_segundo.mov_nombre, dmg2, mult2, primero.morfito_nombre, primero.ps, primero.ps_max])
		else:
			print("%s falló %s" % [segundo.morfito_nombre, mov_segundo.mov_nombre])

		if combate.esta_debilitado(primero):
			print("%s quedó KO" % primero.morfito_nombre)
			break

		# Estado al cierre del turno
		print("PS %s: %d/%d | PS %s: %d/%d"
			% [m1.morfito_nombre, m1.ps, m1.ps_max, m2.morfito_nombre, m2.ps, m2.ps_max])

		turno += 1
