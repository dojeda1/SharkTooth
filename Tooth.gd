extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var is_dead = false
export var state = "empty"

onready var ap = $"%AnimationPlayer"
onready var rot_timer = $"%RotTimer"


# Called when the node enters the scene tree for the first time.
func _ready():
  next_state()
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func grow():
  ap.play("grow")

func idle():
  ap.play("idle")

func empty():
  rot_timer.start(0)
  ap.play("empty")

func dirty_1():
  ap.play("dirty_1")

func dirty_2():
  ap.play("dirty_2")

func dirty_3():
  ap.play("dirty_3")

func rotted():
  is_dead = true
  rot_timer.stop()
  ap.play("rotted")

func remove():
  ap.play("remove")

func _on_Tooth_input_event(viewport, event, shape_idx):
    if (event is InputEventMouseButton && event.pressed):
        print("Clicked " + self.name + " dead:" + str(is_dead))
        if !is_dead:
          clean_tooth()
        else:
          pull_tooth()


func clean_tooth():
  state = 'idle'
  rot_timer.start(0)
  idle()

func pull_tooth():
  state = "empty"
  is_dead = false
  remove()

func next_state():
  print(state)
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
    state = "rotted"
    rotted()
  elif state == "rotted":
#    state = "empty"
    pass



func _on_RotTimer_timeout():
  next_state()
  pass # Replace with function body.
