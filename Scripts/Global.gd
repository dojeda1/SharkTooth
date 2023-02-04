extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Load the custom images for the mouse cursor.
#var arrow = load("res://VFX/Sprites/brush-Sheet.png")
#var beam = load("res://beam.png")


# Called when the node enters the scene tree for the first time.
func _ready():
    # Changes only the arrow shape of the cursor.
    # This is similar to changing it in the project settings.
#    Input.set_custom_mouse_cursor(arrow)

    # Changes a specific shape of the cursor (here, the I-beam shape).
#    Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM)
  pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
