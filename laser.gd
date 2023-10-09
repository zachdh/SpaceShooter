extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()  # Hide the StaticBody2D initially

# Function to show the StaticBody2D
func show_body():
	self.show()

# Function to hide the StaticBody2D
func hide_body():
	self.hide()


func shoot():
	pass
