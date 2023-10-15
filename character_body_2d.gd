extends CharacterBody2D

@export var speed : int = 115
var animated_sprite : AnimatedSprite2D
const MAX_HEALTH = 5
var health = MAX_HEALTH


func _ready():
	animated_sprite = $AnimatedSprite2D
	animated_sprite.animation = "default"
	Global.global_character_position = self.position
	update_health_ui()
	$Camera2D/HealthBar.max_value = MAX_HEALTH

func movement():
	velocity = Vector2()
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	velocity = velocity.normalized() * speed
	
func _on_main_scene_on_space_press():
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

func _physics_process(_delta):
	velocity = Vector2()
	
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		animated_sprite.flip_h = true
	if Input.is_action_pressed('right'):
		velocity.x += 1
		animated_sprite.flip_h = false
	if Input.is_action_pressed('up'):
		velocity.y -= 1
		animated_sprite.animation = "AstronautWalkingUP"
	if Input.is_action_pressed('down'):
		velocity.y += 1
		animated_sprite.animation = "default"
	velocity = velocity.normalized() * speed
	move_and_slide()

	
	if velocity.length() > 0:
		animated_sprite.play()
	else:
		animated_sprite.frame = 4

func chase():
	pass

func hit():
	pass

func update_health_ui():
	$Camera2D/HealthLabel.text = "Health: %s" % health
	$Camera2D/HealthBar.value = health
		
func damage():
	health -= 1
	if health == 0:
		get_tree().paused = true
		print("Game Over!")
	update_health_ui()


func _on_alien_enemy_player_hit():
	damage()
