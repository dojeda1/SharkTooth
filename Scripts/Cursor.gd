extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_active = false
onready var ap = $"%AnimationPlayer"
onready var sprite = $"%Sprite"
var brush_tex = preload("res://VFX/Sprites/brush-Sheet.png")
var forceps_tex = preload("res://VFX/Sprites/forceps-Sheet.png")


# Called when the node enters the scene tree for the first time.
func _ready():
  Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
  State.connect("tooth_check", self, "_tooth_check")
  ap.play("idle")
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  global_position = get_global_mouse_position()
  check_click()

func check_click():
  if Input.is_action_just_pressed("mouse_click"):
    is_active = true
    ap.play("brush")
  elif Input.is_action_just_released("mouse_click"):
    is_active = false
    ap.play("idle")

func _tooth_check(dead):
  if dead:
    sprite.texture = forceps_tex
  else:
    sprite.texture = brush_tex
