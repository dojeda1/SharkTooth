extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var score_label = $"%ScoreLabel"
onready var teeth_label = $"%BadTeethLabel"
onready var ui = $"%Control"
onready var menu = $"%MenuControl"
onready var final_score_label = $"%FinalScoreLabel"
onready var high_score_label = $"%HighScoreLabel"
onready var game_over_sfx = $"%GameOverSFX"

# Called when the node enters the scene tree for the first time.
func _ready():
  State.connect("end_game", self, "_end_game")
  State.reset()
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    score_label.text = '$' + str(State.score)
    teeth_label.text = str(State.bad_teeth)

func reload():
  get_tree().reload_current_scene()

func _end_game():
  play_game_over_sfx()
  final_score_label.text = "$" + str(State.score)
  high_score_label.text = "$" + str(State.high_score)
  ui.visible = false
  menu.visible = true

func play_game_over_sfx():
  game_over_sfx.play()

func _on_Button_pressed():
  reload()
  pass # Replace with function body.
