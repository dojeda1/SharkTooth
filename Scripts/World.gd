extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var score_label = $"%ScoreLabel"
onready var teeth_label = $"%BadTeethLabel"
onready var ui = $"%Control"
onready var menu = $"%MenuControl"
onready var dark_rect = $"%DarkRect"
onready var final_score_label = $"%FinalScoreLabel"
onready var high_score_label = $"%HighScoreLabel"
onready var rect_timer = $"%RectTimer"
onready var game_over_sfx = $"%GameOverSFX"
onready var chomp_sfx = $"%ChompSFX"

onready var score_fx = $"%ScoreFX"
onready var cursor = $"%Cursor"
const cash_fx = preload("res://Scenes/CashFX.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
  State.connect("end_game", self, "_end_game")
  State.connect("add_cash", self, "_add_cash")
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    score_label.text = '$' + str(State.score)
    teeth_label.text = str(State.bad_teeth)

func reload():
  State.reset()
  get_tree().reload_current_scene()

func _end_game():
  rect_timer.start()
  play_game_over_sfx()
  final_score_label.text = "$" + str(State.score)
  high_score_label.text = "$" + str(State.high_score)
  ui.visible = false
  menu.visible = true

func _add_cash(amount):
    var cash = cash_fx.instance()
    cash.update_text(amount)
    var pos = cursor.position - (get_viewport_rect().size/2)
    cash.position = pos
    print("cash:", cash.global_position)
    score_fx.add_child(cash)

func play_game_over_sfx():
  game_over_sfx.play()

func _on_Button_pressed():
  reload()
  pass # Replace with function body.


func _on_RectTimer_timeout():
  dark_rect.visible = true
  chomp_sfx.play()
  pass # Replace with function body.
