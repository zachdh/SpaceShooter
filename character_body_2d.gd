extends CharacterBody2D


var speed = 115.0
var animated_sprite : AnimatedSprite2D

func _ready():
	animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_pressed('left'):
		velocity.x -= 1
		animated_sprite.flip_h = true
	if Input.is_action_pressed('right'):
		velocity.x += 1
		animated_sprite.flip_h = false
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	velocity = velocity.normalized() * speed

	move_and_slide()
	
	if velocity.length() > 0:
		animated_sprite.play()
	else:
		animated_sprite.frame = 4
