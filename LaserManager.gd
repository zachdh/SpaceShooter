extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_ray_gun_player_fired_laser(laser, position, direction, rotation):
	laser.global_position = position
	laser.set_direction(direction)
	laser.set_rotation(rotation)
	add_child(laser)
