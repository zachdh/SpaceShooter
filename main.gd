extends Node2D
signal OnSpacePress
signal OnSpaceRelease

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("space"):
		emit_signal("OnSpacePress")
	else:
		emit_signal("OnSpaceRelease")

