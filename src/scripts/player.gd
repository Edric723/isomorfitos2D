extends CharacterBody2D
@export var SPEED := 120.0

func _physics_process(delta: float) -> void:
	var dir := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if dir != Vector2.ZERO:
		print("dir: ", dir)  # debería mostrar x ≠ 0 al ir izq/der
	velocity = dir * SPEED
	move_and_slide()
