extends Node


var gadget = "brush"
var bad_teeth = 0
var game_over = false
var gadget_active = false
var pulling_teeth = false

var score = 0
var high_score = 0

signal bad_teeth_updated(num)
signal tooth_check(dead)
signal pulling
signal end_game

var save_path: String = "user://sharkData.txt"

# Called when the node enters the scene tree for the first time.
func _ready():
  load_game_data()
  print('currentHiS:', high_score)
  pass # Replace with function body.

func add_bad_teeth(amount):
  bad_teeth += amount
  emit_bad_teeth()
  if bad_teeth >= 6 && !game_over:
    game_over = true
    if score > high_score:
      high_score = score
      save_game_data()
#    print("--GAME OVER--")
    emit_end_game()

func add_points(amount):
  score += amount

func reset():
  score = 0
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

func emit_tooth_check(dead):
  emit_signal("tooth_check", dead)

func save_game_data():
  var save_file = File.new()
  save_file.open(save_path, File.WRITE)
  var new_data = to_json({"high_score": high_score})
  print(new_data)
  save_file.store_line(new_data)
  save_file.close()
  pass

func load_game_data():
  var load_file = File.new()
  if not load_file.file_exists(save_path):
    return
  load_file.open(save_path, File.READ)
  var node_data = parse_json(load_file.get_line())
  high_score = node_data["high_score"]
  load_file.close()
  pass

func reset_data():
  print('Reset Game Data')
  high_score = 0
  save_game_data()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

