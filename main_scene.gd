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



#Thing to do still are redesign the raygun model and orient the character with the raygun when space is pressed
