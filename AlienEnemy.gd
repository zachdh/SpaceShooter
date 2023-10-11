extends Area2D
signal player_detected


func _ready():
	connect("body_entered", $Area2D/CollisionShape2D, "_on_body_entered")


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
