extends CharacterBody2D

@export var speed : int = 80
var animated_sprite : AnimatedSprite2D
const MAX_HEALTH = 5
var health = MAX_HEALTH
var knockback_direction: Vector2
@onready var knockback_timer = $KnockbackTimer
var knockback_status

func _ready():
	animated_sprite = $AnimatedSprite2D
	animated_sprite.animation = "default"
	Global.global_character_position = self.position
#	update_health_ui()
#	$Camera2D/HealthBar.max_value = MAX_HEALTH

func movement():
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	velocity = velocity.normalized() * speed
	
func _physics_process(_delta):
	velocity = Vector2()
	if Global.global_rotation_angle < 0 and Global.global_rotation_angle > (-1*(PI/2)): #Looking UpRight
		animated_sprite.animation = "AstronautWalkingUP"
		animated_sprite.flip_h = false
		movement()
	elif Global.global_rotation_angle < (-1*(PI/2)) and Global.global_rotation_angle > -1*PI: #Looking UpLeft
		animated_sprite.animation = "AstronautWalkingUP"
		animated_sprite.flip_h = true
		movement()
	elif Global.global_rotation_angle > 0 and Global.global_rotation_angle < PI/2: #Looking DownRight
		animated_sprite.animation = "default"
		animated_sprite.flip_h = false
		movement()
	elif Global.global_rotation_angle > PI/2 and Global.global_rotation_angle < PI: #Looking DownLeft
		animated_sprite.animation = "default"
		animated_sprite.flip_h = true
		movement()
	move_and_slide()
	
func _process(_delta):
	if velocity.length() > 0:
		animated_sprite.play()
	else:
		animated_sprite.frame = 4

func chase():
	pass

func hit():
	pass

#func update_health_ui():
#	$Camera2D/HealthLabel.text = "Health: %s" % health
#	$Camera2D/HealthBar.value = health

func _on_alien_enemy_player_hit(rotation_angle):
	health -= 1
	if health == 0:
		health = MAX_HEALTH
		#get_tree().paused = true
		print("Game Over!")
#	update_health_ui()

func _on_camera_detector_1_body_exited(body):
	if body == self:
		$"../CameraTransitions/Barrier1/CollisionShape2D".set_deferred("disabled", false)
		var tween_position = create_tween()
		var tween_zoom = create_tween()
		tween_position.tween_property($"../Camera2D", "position", Vector2(197,60), 1)
		tween_zoom.tween_property($"../Camera2D", "zoom", Vector2(5,5), 1)

func _on_camera_detector_2_body_exited(body):
	if body == self:
		$"../CameraTransitions/Barrier2/CollisionShape2D".set_deferred("disabled", false)
		var tween_position = create_tween()
		var tween_zoom = create_tween()
		tween_position.tween_property($"../Camera2D", "position", Vector2(200,-24), 1)
		tween_zoom.tween_property($"../Camera2D", "zoom", Vector2(6,5.8), 1)
		
func _on_camera_detector_3_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body == self:
		$"../CameraTransitions/Barrier3/CollisionShape2D".set_deferred("disabled", false)
		var tween_position = create_tween()
		var tween_zoom = create_tween()
		tween_position.tween_property($"../Camera2D", "position", Vector2(424,2), 1)
		tween_zoom.tween_property($"../Camera2D", "zoom", Vector2(6,6), 1)
		$"../Camera2D2".make_current()
		
