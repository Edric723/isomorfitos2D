extends TileMapLayer

const MURO_ATLAS := Vector2i(6, 5)
const MURO_SOURCE := 0 # poné el source_id real de tu TileSet/Atlas

func _ready() -> void:
	for filled: Vector2i in get_used_cells():
		for n: Vector2i in get_surrounding_cells(filled):
			if get_cell_source_id(n) == -1:
				set_cell(n, MURO_SOURCE, MURO_ATLAS, 0)

#func _ready() -> void:
	#for filled: Vector2i in get_used_cells():
		#for n: Vector2i in get_surrounding_cells(filled):
			#if get_cell_source_id(n) == -1:
				## Usa el mismo source_id que el del tile lleno
				#set_cell(n, get_cell_source_id(filled), Vector2i.ZERO)
