extends StaticBody2D

@export var Laser : PackedScene
@onready var end_of_gun = $EndOfGun
signal player_fired_laser(laser, position, direction, rotation)

func _ready():
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position = get_local_mouse_position()
	Global.global_direction = (mouse_position - $Sprite2D.position)
	Global.global_rotation_angle = atan2(Global.global_direction.y, Global.global_direction.x)
	if Global.global_rotation_angle < -1*(PI/2) or Global.global_rotation_angle > PI/2:
		$Sprite2D.flip_v = true
		$Sprite2D.rotation = Global.global_rotation_angle
	else:
		$Sprite2D.flip_v = false
		$Sprite2D.rotation = Global.global_rotation_angle
	if Global.global_rotation_angle < -1*(PI/4) and Global.global_rotation_angle > -1*(3*PI/4):
		self.show_behind_parent = true
	else:
		self.show_behind_parent = false


func _on_main_scene_on_space_press():
	self.show()
	
func _on_main_scene_on_space_release():
	self.hide()
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("space"):
		if event.is_action_released("click"):
			shoot()
		
func shoot():
	var laser_instance = Laser.instantiate()
	laser_instance.global_position = end_of_gun.global_position
	var target = get_global_mouse_position()
	var direction_to_mouse = end_of_gun.global_position.direction_to(target).normalized()
	var rotation = atan2(direction_to_mouse.y, direction_to_mouse.x)
	emit_signal("player_fired_laser", laser_instance, end_of_gun.global_position, direction_to_mouse, rotation)

