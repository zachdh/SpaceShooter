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
	update_health_ui()
	$Camera2D/HealthBar.max_value = MAX_HEALTH

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
	if knockback_status == true:
		print('knockback')
		print(knockback_direction)
		velocity = knockback_direction * speed
		move_and_slide()
		_on_knockback_timer_timeout()
	elif Global.global_rotation_angle < 0 and Global.global_rotation_angle > (-1*(PI/2)): #Looking UpRight
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

func update_health_ui():
	$Camera2D/HealthLabel.text = "Health: %s" % health
	$Camera2D/HealthBar.value = health

func _on_alien_enemy_player_hit(rotation_angle):
	print("you have been hit")
	knockback_direction = (pointOnCircle(self.global_position, 250, rotation_angle)- self.global_position).normalized()
	knockback_status = true
	health -= 1
	if health == 0:
		health = MAX_HEALTH
		#get_tree().paused = true
		print("Game Over!")
	update_health_ui()

func pointOnCircle(center: Vector2, radius: float, angle_degrees: float) -> Vector2:
	var x = center.x + radius * cos(angle_degrees)
	var y = center.y + radius * sin(angle_degrees)
	return Vector2(x, y)

func _on_knockback_timer_timeout():
	knockback_status = false
