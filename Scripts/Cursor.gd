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
  ap.play("idle")
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  global_position = get_global_mouse_position()
  check_click()

#
#  Input.set_custom_mouse_cursor(texture.get_frame_texture(texture.current_frame), Input.CURSOR_ARROW, Vector2(texture.get_width(), texture.get_height()) / 2)
  pass

func check_click():
  if Input.is_action_just_pressed("mouse_click"):
    is_active = true
    ap.play("brush")
    print('BRUSH')
  elif Input.is_action_just_released("mouse_click"):
    is_active = false
    ap.play("idle")
    print('IDLE')


func _on_Cursor_area_entered(area):
  if area.is_in_group("tooth"):
    print('Tooth')
    print(area.is_dead)
    if area.is_dead:
      sprite.texture = forceps_tex
    else:
      sprite.texture = brush_tex
  pass # Replace with function body.
