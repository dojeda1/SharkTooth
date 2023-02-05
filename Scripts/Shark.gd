extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ap = $"%AnimationPlayer"
onready var eyes_ap = $"%EyesAnimationPlayer"
onready var anger_ap = $"%AngerAnimationPlayer"


# Called when the node enters the scene tree for the first time.
func _ready():
  State.connect("bad_teeth_updated", self, "_bad_teeth_updated")
  State.connect("pulling", self, "_pulling")
  ap.play("idle")
  idle()
  choose_anger()
  anger_ap.play("calm")
  pass # Replace with function body.

func idle():
  eyes_ap.play("idle")

func mad_1():
  eyes_ap.play("mad_1")

func mad_2():
  eyes_ap.play("mad_2")

func pain():
  eyes_ap.play("pain")

func _bad_teeth_updated(num):
  choose_anger()
  if !State.pulling_teeth:
    choose_idle()

func _pulling():
  pain()

func choose_idle():
  if State.bad_teeth < 2:
    idle()
  elif State.bad_teeth < 4:
    mad_1()
  else:
    mad_2()

func choose_anger():
  print('BT:', str(State.bad_teeth))
  if State.bad_teeth < 2:
    print('calm')
    anger_ap.play("calm")
  elif State.bad_teeth < 4:
    print('a1')
    anger_ap.play("anger_1")
  elif State.bad_teeth < 5:
    print('A2')
    anger_ap.play("anger_2")
  else:
    print('A3')
    anger_ap.play("anger_3")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
