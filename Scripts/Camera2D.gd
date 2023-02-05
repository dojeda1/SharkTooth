extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_zooming = false


# Called when the node enters the scene tree for the first time.
#func _ready():
#  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

var smooth_zoom = 1
var target_zoom = .12
var smooth_offset = Vector2(0, 0)
var target_offset = Vector2(0, 40)

const ZOOM_SPEED = 5

func _ready():
#  begin_zoom()
  State.connect("end_game", self, "_end_game")
  pass

func _physics_process(delta):
  check_zoom(delta)

func check_zoom(delta):
  if is_zooming:
    smooth_zoom = lerp(smooth_zoom, target_zoom, ZOOM_SPEED * delta)
    smooth_offset = lerp(smooth_offset, target_offset, ZOOM_SPEED * delta)
    if smooth_zoom != target_zoom:
      set_zoom(Vector2(smooth_zoom, smooth_zoom))
      set_offset(target_offset)

func begin_zoom():
  set_physics_process(true)
  is_zooming = true

func _end_game():
  begin_zoom()
