extends AnimatedSprite2D

@onready var area_2d: Area2D = $Area2D
const RUTA_DESTINO := "res://src/scenes/test.tscn"  # <-- AJUSTA ESTA RUTA A TU ESCENA DESTINO

var _ya_teleport := false

func _ready() -> void:
	print("[Portal] current_scene:", get_tree().current_scene and get_tree().current_scene.scene_file_path)
	print("[Portal] monitoring=", area_2d.monitoring, " mask=", area_2d.collision_mask)
	area_2d.body_entered.connect(_on_area_body_entered)

func _on_area_body_entered(body: Node) -> void:
	if _ya_teleport:
		return
	print("[Portal] Entró:", body, "| is Player group:", body.is_in_group("Player"))
	if body.is_in_group("Player"):
		_ya_teleport = true
		area_2d.set_deferred("monitoring", false)
		call_deferred("_cambiar_de_escena")

func _cambiar_de_escena() -> void:
	get_tree().paused = false  # por si estaba pausado
	var pack := load(RUTA_DESTINO)
	if pack == null:
		push_error("[Portal] No se pudo cargar: " + RUTA_DESTINO)
		return
	if not (pack is PackedScene):
		push_error("[Portal] Recurso no es PackedScene: " + str(pack))
		return
	var err := get_tree().change_scene_to_packed(pack)
	print("[Portal] change_scene_to_packed → err =", err)  # 0 = OK
