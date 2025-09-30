#extends CharacterBody2D
#@export var SPEED := 120.0
#@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
#
#func _physics_process(delta: float) -> void:
	#var dir := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	#if dir != Vector2.ZERO:
		#velocity = dir * SPEED
	#move_and_slide()

extends CharacterBody2D

@export var SPEED := 120.0
@export var DEADZONE := 0.15

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var _last_dir := Vector2.DOWN

# Mantengo el orden normal (east, north_east, north, ...)
const DIR_NAMES := [
	"east",        # 0°
	"north_east",  # 45°
	"north",       # 90°
	"north_west",  # 135°
	"west",        # 180°
	"south_west",  # 225°
	"south",       # 270°
	"south_east"   # 315°
]

func _physics_process(delta: float) -> void:
	var dir := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if dir.length() > DEADZONE:
		dir = dir.normalized()
		velocity = dir * SPEED
		var anim := _dir_to_anim(dir)
		if sprite_2d.animation != anim:
			sprite_2d.play(anim)
		_last_dir = dir
	else:
		velocity = Vector2.ZERO
		if sprite_2d.animation != "idle":
			sprite_2d.play("idle")

	move_and_slide()

func _dir_to_anim(dir: Vector2) -> String:
	var deg := rad_to_deg(dir.angle())
	deg = -deg                               # <<< cambio clave para invertir eje Y
	deg = fposmod(deg + 360.0, 360.0)
	var idx := int(round(deg / 45.0)) % 8
	return DIR_NAMES[idx]
