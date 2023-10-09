extends StaticBody2D



func _ready():
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position = get_local_mouse_position()
	Global.global_direction = (mouse_position - $RayGun.position)
	Global.global_rotation_angle = atan2(Global.global_direction.y, Global.global_direction.x)
	if Global.global_rotation_angle < -1*(PI/2) or Global.global_rotation_angle > PI/2:
		$RayGun.flip_v = true
	else:
		$RayGun.flip_v = false
		$RayGun.rotation = Global.global_rotation_angle
	if Global.global_rotation_angle < -1*(PI/4) and Global.global_rotation_angle > -1*(3*PI/4):
		$".".show_behind_parent = true
	else:
		$".".show_behind_parent = false


func _on_main_scene_on_space_press():
	self.show()
	
func _on_main_scene_on_space_release():
	self.hide()
