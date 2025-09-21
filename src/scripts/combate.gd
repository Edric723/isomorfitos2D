# bucle de combate principal
func emular_combate(t1: Entrenador, t2: Entrenador) -> void:
	# mientras ambos tengan al menos 1 morfito con vida
	while not tiene_equipo_debilitado(t1.morfis) and not tiene_equipo_debilitado(t2.morfis):
		# acá cada entrenador debe elegir su decisión (ataque o cambio, a futuro se agregarían inventario  y huida.)
		var d1: Dictionary = obtener_decision(t1)  # <- esto lo defines según tu UI/IA
		var d2: Dictionary = obtener_decision(t2)

		var activo1: Morfito = elegir_morfi_activo(t1)
		var activo2: Morfito = elegir_morfi_activo(t2)

		var res: Dictionary = simular_turno(t1, t2, activo1, activo2, d1, d2)

		# aplicar los cambios de morfi activos
		if res["cambio_t1"] != null:
			activo1 = res["cambio_t1"]
		if res["cambio_t2"] != null:
			activo2 = res["cambio_t2"]

		# si alguien quedó KO, deberías forzar reemplazo afuera
		if res["ko_t1"]:
			print("Entrenador1 debe elegir nuevo Morfito")
		if res["ko_t2"]:
			print("Entrenador2 debe elegir nuevo Morfito")

	# cuando salga del while, anunciar al ganador
	anunciar_ganador(t1, t2)

# chequea si todo el equipo está debilitado
func tiene_equipo_debilitado(morfis: Array) -> bool:
	for m in morfis:
		if not esta_debilitado(m):
			return false
	return true
	
# chequea si un morfito está KO
func esta_debilitado(morfito: Morfito) -> bool:
	return morfito.ps <= 0


enum AccionTipo { ATACAR, CAMBIAR }

var _empate_alterna := true

# --- helpers para crear decisiones ---
func atacar(mov: Movimiento) -> Dictionary:
	return {"tipo": AccionTipo.ATACAR, "mov": mov, "nuevo": null}

func cambiar(nuevo_morfi: Morfito) -> Dictionary:
	return {"tipo": AccionTipo.CAMBIAR, "mov": null, "nuevo": nuevo_morfi}

# --- decidir quién pega primero ---
func decidir_primer_golpe(morfi1: Morfito, morfi2: Morfito) -> Morfito:
	if morfi1.velocidad > morfi2.velocidad:
		return morfi1
	if morfi2.velocidad > morfi1.velocidad:
		return morfi2
	var primero: Morfito = morfi1 if _empate_alterna else morfi2
	if _empate_alterna:
		primero = morfi1
	else:
		primero = morfi2
	_empate_alterna = not _empate_alterna
	return primero

# --- función principal ---
# d1 y d2: diccionarios creados con atacar() o cambiar()
# return: diccionario con cambios y KOs
func simular_turno(t1: Entrenador, t2: Entrenador, morfi1: Morfito, morfi2: Morfito, d1: Dictionary, d2: Dictionary) -> Dictionary:
	# 1) ambos cambian
	if d1.tipo == AccionTipo.CAMBIAR and d2.tipo == AccionTipo.CAMBIAR:
		return {"cambio_t1": d1.nuevo, "cambio_t2": d2.nuevo, "ko_t1": false, "ko_t2": false, "ganador": null}

	# 2) uno cambia y el otro ataca
	if d1.tipo == AccionTipo.CAMBIAR and d2.tipo == AccionTipo.ATACAR:
		var n1: Morfito = d1.nuevo
		ejecutar_ataque(morfi2, d2.mov, n1)
		var ko1 := esta_debilitado(n1)
		return {"cambio_t1": n1, "cambio_t2": null, "ko_t1": ko1, "ko_t2": false, "ganador": morfi2 if ko1 else null}

	if d2.tipo == AccionTipo.CAMBIAR and d1.tipo == AccionTipo.ATACAR:
		var n2: Morfito = d2.nuevo
		ejecutar_ataque(morfi1, d1.mov, n2)
		var ko2 := esta_debilitado(n2)
		return {"cambio_t1": null, "cambio_t2": n2, "ko_t1": false, "ko_t2": ko2, "ganador": morfi1 if ko2 else null}

	# 3) ambos atacan
	var m1: Movimiento = d1.mov
	var m2: Movimiento = d2.mov

	var primero: Morfito = decidir_primer_golpe(morfi1, morfi2)
	var segundo: Morfito = morfi2 if primero == morfi1 else morfi1

	var mov_primero: Movimiento = m1 if primero == morfi1 else m2
	var mov_segundo: Movimiento = m1 if segundo == morfi1 else m2

	ejecutar_ataque(primero, mov_primero, segundo)
	if esta_debilitado(segundo):
		return {"cambio_t1": null, "cambio_t2": null, "ko_t1": (segundo == morfi1), "ko_t2": (segundo == morfi2), "ganador": primero}

	ejecutar_ataque(segundo, mov_segundo, primero)
	if esta_debilitado(primero):
		return {"cambio_t1": null, "cambio_t2": null, "ko_t1": (primero == morfi1), "ko_t2": (primero == morfi2), "ganador": segundo}

	# nadie se debilitò
	return {"cambio_t1": null, "cambio_t2": null, "ko_t1": false, "ko_t2": false, "ganador": null}


func acierta_Ataque(mov: Movimiento) -> bool:

	var _numero_aleatorio: int = 1 #acá va el rng para que pueda existir una chance de fallo siempre, por más puntería q haya.
	return _numero_aleatorio < mov.Punteria



func calcular_Danio(mov: Movimiento, morfiA: Morfito, morfiB: Morfito) -> float:
 
	var  ataque: float 
	var defensa: float

	if mov.categoria == "Físico":
	  
		ataque = morfiA.Atq 
		defensa = morfiB.Def
		
	else:
	  
		ataque = morfiB.atq
		defensa = morfiA.DefEsp
	  

	  # Cálculo del daño base
	var danio_base: float = ((42 * mov.Poder * (ataque / defensa)) / 50) + 2 
	# HAY Q MODIFICAR El 42 para que lo calcule exacto por nivel, 42 es el default de level 100.


	  # Calculamos el STAB.          
	var stab: float
	if (morfiA.Tipo == mov.Tipo): # Si el tipo del morfito coincide con el tipo del movimiento
		stab = 1.5 # Se aplica STAB
	else:
		stab = 1 # No se aplica STAB

	  # Efectividad de tipo (utiliza la tabla de tipos para definir la eficacia).
	var efectividad: float = Efectividades.obtener_efectividad(mov.Tipo, morfiB.Tipo);

	  # Variación aleatoria (Este es el valor "random" que permite aportar aleatoriedad a los combates).
	var variacion_default:int  = randi_range(217,256) # Entre 217 y 255 inclusive, por los bytes que tenian como limitación.
	var variacion:float = variacion_default / 255 # ~0.85 a 1.0 , esta es la variación original de la primer Gen

	  #Mínimo: 85% del daño base (multiplicado por 0.85)
	  #Máximo: 100 % del daño base(multiplicado por 1.00)
	  #Rango de variación: del 85 % al 100 %.


	  # Calcular el daño final
	var danio_final: float = danio_base * stab * efectividad * variacion

	return danio_final;
  




# COMPLETARRRRR

func ejecutar_ataque(morfiA: Morfito, mov: Movimiento, morfiB:Morfito) -> void:
	#Este es el q debería encargarse de todo lo relacionado al ataque, golpear, restar vida.
	if acierta_Ataque(mov):
		pass #falta

func obtener_decision(trainer: Entrenador) -> Dictionary:
	return {}  # por ahora diccionario vacío

func elegir_morfi_activo(trainer: Entrenador) -> Morfito:
	return null  # si Morfito es una clase, null es aceptado

func anunciar_ganador(t1: Entrenador, t2: Entrenador) -> Entrenador:
	return null
