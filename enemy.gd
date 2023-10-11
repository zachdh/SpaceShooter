extends Node2D

signal player_detected


func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_detected():
	var 



func _on_area_2d_body_entered(body):
		if body.is_in_group("player"):
			emit_signal("player_detected", body)
