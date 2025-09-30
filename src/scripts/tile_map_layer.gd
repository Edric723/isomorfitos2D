extends TileMapLayer

const MURO_ATLAS := Vector2i(10, 8)
const MURO_SOURCE := 0 # poné el source_id real de tu TileSet/Atlas

func _ready() -> void:
	for filled: Vector2i in get_used_cells():
		for n: Vector2i in get_surrounding_cells(filled):
			if get_cell_source_id(n) == -1:
				set_cell(n, MURO_SOURCE, MURO_ATLAS, 0)
