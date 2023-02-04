extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var score_label = $"%ScoreLabel"
onready var teeth_label = $"%BadTeethLabel"

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    score_label.text = '$' + str(State.score)
    teeth_label.text = str(State.bad_teeth)
