extends CharacterBody2D

@export var speed = 80
var animated_sprite : AnimatedSprite2D
const MAX_HEALTH = 5
var health = MAX_HEALTH

func _ready():
	animated_sprite = $AnimatedSprite2D
	animated_sprite.animation = "default"
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

func hit():
	pass

func update_health_ui():
	$Camera2D/HealthBar.value = health

func _on_alien_enemy_damage(rotation_angle):
	health -= 1
	update_health_ui()
	if health == 0:
		get_tree().change_scene_to_file("res://game_over.tscn")

#add more spawnpoints
#tune spawntiming possibly increase the number that spawn as the round progresses
#make the enemies do damage*
#draw some torches
#add score feature*
	#emit signal from each instance of an alien when they are killed which runs a function that accumulates a total score
	#add 1 to a global score variable when an alien is killed
#make the enemies stay inside the walls*
	#I have no idea watch lots of tutorials
#maybe add a highscore feature for multiple players
	#at the very end if youre not tired of this game

