extends Node


var gadget = "brush"
var bad_teeth = 0
var game_over = false
var gadget_active = false
var pulling_teeth = false

var score = 0

signal bad_teeth_updated(num)
signal pulling
signal end_game

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

func add_bad_teeth(amount):
  bad_teeth += amount
  emit_bad_teeth()
  if bad_teeth >= 6 && !game_over:
    game_over = true
#    print("--GAME OVER--")
    emit_end_game()

func add_points(amount):
  score += amount

func reset():
  bad_teeth = 0
  game_over = false
  gadget_active = false
  pulling_teeth = false

func emit_bad_teeth():
  emit_signal("bad_teeth_updated", bad_teeth)

func emit_pulling():
  emit_signal("pulling")

func emit_end_game():
  emit_signal("end_game")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
