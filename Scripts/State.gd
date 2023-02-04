extends Node


var gadget = "brush"
var bad_teeth = 0
var game_over = false
var gadget_active = false

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

func add_bad_teeth(amount):
  bad_teeth += amount
  print("bad_teeth:" + str(bad_teeth))
  if bad_teeth >= 6:
    game_over = true
    print("--GAME OVER--")

func add_points(amount):
  score += amount
  print("score:" + str(score))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
