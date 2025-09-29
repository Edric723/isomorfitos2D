extends Node2D

@onready var nombre_m_1: Label     = $"Combat_scene/Combat Hud/Arriba/Zocalo_Superior/morfi1/Nombre_m1"
@onready var vida_m_1: ProgressBar = $"Combat_scene/Combat Hud/Arriba/Zocalo_Superior/morfi1/Vida_m1"
@onready var nombre_m_2: Label     = $"Combat_scene/Combat Hud/Arriba/Zocalo_Superior/morfi2/Nombre_m2"
@onready var vida_m_2: ProgressBar = $"Combat_scene/Combat Hud/Arriba/Zocalo_Superior/morfi2/Vida_m2"
@onready var text_edit: RichTextLabel = $"Combat_scene/Combat Hud/Abajo/Zocalo_Inferior/Status/TextEdit"

@onready var atacar: Button = $"Combat_scene/Combat Hud/Abajo/Zocalo_Inferior/Botonera/Grilla Botones/Atacar"
@onready var cambiar: Button = $"Combat_scene/Combat Hud/Abajo/Zocalo_Inferior/Botonera/Grilla Botones/Cambiar"
@onready var inventario: Button = $"Combat_scene/Combat Hud/Abajo/Zocalo_Inferior/Botonera/Grilla Botones/Inventario"
@onready var huir: Button = $"Combat_scene/Combat Hud/Abajo/Zocalo_Inferior/Botonera/Grilla Botones/Huir"



# --- Estado del combate ---
var combate: Combate
var m1: Morfito
var m2: Morfito
var t1: Entrenador
var t2: Entrenador
var turno: int = 1
var in_action := false  # evita doble click durante la animación/mensajes

func _ready() -> void:
	randomize()

	# Instancias base
	combate = Combate.new()

	# Movimientos
	var mov_umbra := Movimiento.new("Ascuas", "Umbra", "Especial", 40, 95)
	var mov_aqua  := Movimiento.new("Pistola Agua", "Aqua", "Especial", 40, 100)

	# Morfitos
	m1 = Morfito.new("Blazito","Umbra",10,7,12,6,60,60,9,[mov_umbra])
	m2 = Morfito.new("Aquita","Aqua", 9,8,11,7,60,60,9,[mov_aqua])

	# Entrenadores
	t1 = Entrenador.new("Rojo", [m1])
	t2 = Entrenador.new("Azul", [m2])

	# HUD
	_init_hud(m1, m2)
	text_edit.clear()
	_log_linea("Elige una acción…")
	_log_linea("Atacar avanza el combate por turnos.")
	_scroll_y_pausa()

	# Conectar botones
	atacar.pressed.connect(_on_atacar_pressed)
	cambiar.pressed.connect(_on_cambiar_pressed)
	inventario.pressed.connect(_on_inventario_pressed)
	huir.pressed.connect(_on_huir_pressed)

func _init_hud(a: Morfito, b: Morfito) -> void:
	nombre_m_1.text = a.nombre
	nombre_m_2.text = b.nombre
	vida_m_1.max_value = a.ps_max
	vida_m_2.max_value = b.ps_max
	vida_m_1.value = a.ps
	vida_m_2.value = b.ps

func _update_hud() -> void:
	vida_m_1.value = clamp(m1.ps, 0, m1.ps_max)
	vida_m_2.value = clamp(m2.ps, 0, m2.ps_max)

# --------------------------
# Botones
# --------------------------
func _on_atacar_pressed() -> void:
	if in_action:
		return
	if _combate_finalizado():
		return
	in_action = true
	await _resolver_turno()
	in_action = false

func _on_cambiar_pressed() -> void:
	if in_action:
		return
	_log_linea("Intentas cambiar de Morfito…")
	_log_linea("No hay morfitos disponibles.")
	_scroll_y_pausa()

func _on_inventario_pressed() -> void:
	if in_action:
		return
	_log_linea("Abres tu inventario…")
	_log_linea("No tienes mochila.")
	_scroll_y_pausa()

func _on_huir_pressed() -> void:
	if in_action:
		return
	_log_linea("Intentas huir…")
	_log_linea("No puedes huir del combate.")
	_scroll_y_pausa()

# --------------------------
# Lógica de un turno (avanza al apretar Atacar)
# --------------------------
func _combate_finalizado() -> bool:
	if combate.tiene_equipo_debilitado(t1.morfis) or combate.tiene_equipo_debilitado(t2.morfis):
		return true
	return false

func _resolver_turno() -> void:
	if _combate_finalizado():
		return

	_log_linea("\n-- Turno %d --" % turno)

	# Elegimos movimientos (placeholder: primer movimiento de cada uno)
	var mov1: Movimiento = m1.movimientos[0]
	var mov2: Movimiento = m2.movimientos[0]

	# Orden del turno
	var primero: Morfito = combate.definir_primer_golpe(m1, m2)
	var segundo: Morfito = (m2 if primero == m1 else m1)
	var mov_primero: Movimiento = (mov1 if primero == m1 else mov2)
	var mov_segundo: Movimiento = (mov1 if segundo == m1 else mov2)

	_log_linea("Ataca primero: %s" % primero.nombre)
	await _scroll_y_pausa()

	# ---- Golpe 1 ----
	var hit1: bool = combate.acierta_Ataque(mov_primero)
	if hit1:
		var dmg1: int = int(round(combate.calcular_Danio(mov_primero, primero, segundo)))
		var mult1: float = Efectividades.obtener_efectividad(mov_primero.mov_tipo, segundo.tipo)
		segundo.ps = max(0, segundo.ps - dmg1)
		_log_linea("%s usó %s → daño %d (x%.2f)." % [primero.nombre, mov_primero.mov_nombre, dmg1, mult1])
		_log_linea("%s: %d/%d" % [segundo.nombre, segundo.ps, segundo.ps_max])
	else:
		_log_linea("%s intenta usar %s…" % [primero.nombre, mov_primero.mov_nombre])
		_log_linea("¡%s falló!" % primero.nombre)
	_update_hud()
	await _scroll_y_pausa()

	if combate.esta_debilitado(segundo):
		_log_linea("%s quedó KO" % segundo.nombre)
		_log_linea("¡%s gana el combate!" % (m1.nombre if segundo == m2 else m2.nombre))
		_scroll_y_pausa()
		_finalizar_ui()
		return

	# ---- Golpe 2 ----
	var hit2: bool = combate.acierta_Ataque(mov_segundo)
	if hit2:
		var dmg2: int = int(round(combate.calcular_Danio(mov_segundo, segundo, primero)))
		var mult2: float = Efectividades.obtener_efectividad(mov_segundo.mov_tipo, primero.tipo)
		primero.ps = max(0, primero.ps - dmg2)
		_log_linea("%s usó %s → daño %d (x%.2f)." % [segundo.nombre, mov_segundo.mov_nombre, dmg2, mult2])
		_log_linea("%s: %d/%d" % [primero.nombre, primero.ps, primero.ps_max])
	else:
		_log_linea("%s intenta usar %s…" % [segundo.nombre, mov_segundo.mov_nombre])
		_log_linea("¡%s falló!" % segundo.nombre)
	_update_hud()
	await _scroll_y_pausa()

	if combate.esta_debilitado(primero):
		_log_linea("%s quedó KO" % primero.nombre)
		_log_linea("¡%s gana el combate!" % (m1.nombre if primero == m2 else m2.nombre))
		_scroll_y_pausa()
		_finalizar_ui()
		return

	# Estado al cierre del turno
	_log_linea("PS %s: %d/%d" % [m1.nombre, m1.ps, m1.ps_max])
	_log_linea("PS %s: %d/%d" % [m2.nombre, m2.ps, m2.ps_max])
	await _scroll_y_pausa()

	turno += 1

# --------------------------
# Utilidades de log y UI
# --------------------------
func _log_linea(texto: String) -> void:
	text_edit.append_text(texto + "\n")

func _scroll_y_pausa() -> void:
	# Muestra "de a 2 líneas": este helper lo llamamos tras cada par lógico de mensajes
	text_edit.scroll_to_line(text_edit.get_line_count() - 1)
	await get_tree().create_timer(0.5).timeout

func _finalizar_ui() -> void:
	atacar.disabled = true
	cambiar.disabled = true
	inventario.disabled = true
	huir.disabled = true
