extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var is_dead = false
export var is_dirty = false
var is_active = false
export var state = "empty"
export var delay = 0

onready var ap = $"%AnimationPlayer"
onready var wiggle_ap = $"%WiggleAnimationPlayer"
onready var init_rot_timer = $"%InitRotTimer"
onready var rot_timer = $"%RotTimer"
onready var brush_timer = $"%BrushTimer"
onready var pull_timer = $"%PullTimer"
onready var delay_timer = $"%DelayTimer"

# Called when the node enters the scene tree for the first time.
func _ready():
  ap.play(state)
  if state != 'empty':
    init_rot_timer.wait_time = Global.rand(5, 10)
  #  init_rot_timer.wait_time = 0.2
    init_rot()
  if delay > 0:
    delay_timer.wait_time = delay
    delay_timer.start(0)
  else:
    next_state()
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  if (Input.is_action_just_released("mouse_click")):
#    reset_tooth()

func init_rot():
  init_rot_timer.start(0)

func grow():
  ap.play("grow")

func idle():
  is_dirty = false
  init_rot_timer.wait_time = Global.rand(5, 18)
#  init_rot_timer.wait_time = 0.2
  init_rot()
  rot_timer.stop()
  ap.play("idle")

func empty():
  rot_timer.start(0)
  ap.play("empty")

func dirty_1():
  is_dirty = true
  ap.play("dirty_1")

func dirty_2():
  is_dirty = true
  ap.play("dirty_2")

func dirty_3():
  is_dirty = true
  ap.play("dirty_3")

func rotting():
  is_dirty = true
  ap.play("dirty_3")
  wiggle_ap.play("wiggle_large")

func rotted():
  is_dead = true
  rot_timer.stop()
  State.add_bad_teeth(1)
  ap.play("rotted")
  wiggle_ap.play("idle")

func remove():
  is_dead = false
  State.pulling_teeth = false
  State.add_bad_teeth(-1)
  State.add_points(500)
  ap.play("remove")

func attempt_clean():
    if !is_dead:
      begin_brush()
    else:
      begin_pull()

func reset_tooth():
  if state == "rotting":
    wiggle_ap.play("wiggle_large")
  else:
    wiggle_ap.play("idle")
  pull_timer.stop()
  brush_timer.stop()
  rot_timer.start(0)
  State.pulling_teeth = false
  State.emit_bad_teeth()

func clean_tooth():
  if is_active:
    attempt_clean()
  else:
    if state == "idle":
      rot_timer.start(0)
    else:
      init_rot()
  prev_state()

func pull_tooth():
  state = "empty"
  remove()

func begin_brush():
  brush_timer.start(0)
  wiggle_ap.play("wiggle_small")

func begin_pull():
  State.pulling_teeth = true
  State.emit_pulling()
  wiggle_ap.play("wiggle_large")
  pull_timer.start(0)

func next_state():
#  print(state)
  if state == "empty":
    state = "grow"
    grow()
  elif state == "grow":
    state = "idle"
    idle()
  elif state == "idle":
    state = "dirty_1"
    dirty_1()
  elif state == "dirty_1":
    state = "dirty_2"
    dirty_2()
  elif state == "dirty_2":
    state = "dirty_3"
    dirty_3()
  elif state == "dirty_3":
    state = "rotting"
    rotting()
  elif state == "rotting":
    state = "rotted"
    rotted()
  elif state == "rotted":
#    state = "empty"
    pass

func prev_state():
  if state == "dirty_3" || state == "rotting":
    state = "dirty_2"
    State.add_points(300)
    dirty_2()
  elif state == "dirty_2":
    state = "dirty_1"
    State.add_points(200)
    dirty_1()
  elif state == "dirty_1":
    state = "idle"
    State.add_points(100)
    idle()

func _on_Tooth_input_event(viewport, event, shape_idx):
  if (event is InputEventMouseButton && event.pressed):
    is_active = true
    rot_timer.stop()
#    print("Clicked " + self.name + " dead:" + str(is_dead))
    attempt_clean()
  elif (event is InputEventMouseButton && !event.pressed && is_active):
    is_active = false
    reset_tooth()

func _on_Tooth_mouse_exited():
  if is_active:
    is_active = false
    reset_tooth()
  pass # Replace with function body.


func _on_RotTimer_timeout():
  next_state()
  pass # Replace with function body.


func _on_BrushTimer_timeout():
  wiggle_ap.play("idle")
  clean_tooth()
  pass # Replace with function body.


func _on_PullTImer_timeout():
  wiggle_ap.play("idle")
  pull_tooth()
  pass # Replace with function body.


func _on_InitRotTimer_timeout():
  next_state()
  rot_timer.start(0)
  pass # Replace with function body.


func _on_DelayTimer_timeout():
  next_state()
  pass # Replace with function body.
