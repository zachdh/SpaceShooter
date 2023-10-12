extends Node2D

signal player_detected
var enemypos = get_position()
var speed = 150

func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_player_detected(delta):
	print("Player Detected!")
	enemypos.x.move_toward(Global.global_character_position.xd, delta)
	enemypos.y.move_toward(Global.global_character_position.y, delta)



func _on_area_2d_body_entered(body):
	print(body.get_name())
	if body.get_name() == "CharacterBody2D":
		emit_signal("player_detected", body)
