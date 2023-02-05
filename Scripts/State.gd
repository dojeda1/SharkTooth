extends Node


var gadget = "brush"
var bad_teeth = 0
var game_over = false
var gadget_active = false
var pulling_teeth = false

var score = 0

signal bad_teeth_updated(num)
signal pulling

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

func add_bad_teeth(amount):
  bad_teeth += amount
  emit_bad_teeth()
  if bad_teeth >= 6:
    game_over = true
    print("--GAME OVER--")

func add_points(amount):
  score += amount

func emit_bad_teeth():
  emit_signal("bad_teeth_updated", bad_teeth)

func emit_pulling():
  emit_signal("pulling")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
