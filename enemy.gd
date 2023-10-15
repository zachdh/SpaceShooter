extends CharacterBody2D

signal playerHit
signal enemyHit
@export var speed : int = 25
var player_position
var target_position
var target = null
var EnemySprite : AnimatedSprite2D
var rotationDir
const MAX_HEALTH = 3
var health = MAX_HEALTH

func _ready():
	EnemySprite = $AlienAnimation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if target != null:
		player_position = target.position
		target_position = (player_position - self.position).normalized()
		rotationDir = atan2(target_position.y, target_position.x)
		if rotationDir < 0 and rotationDir > (-1*(PI/2)): #Looking UpRight
			EnemySprite.flip_h = false
		elif rotationDir < (-1*(PI/2)) and rotationDir > -1*PI: #Looking UpLeft
			EnemySprite.flip_h = true
		elif rotationDir > 0 and rotationDir < PI/2: #Looking DownRight
			EnemySprite.flip_h = false
		elif rotationDir > PI/2 and rotationDir < PI: #Looking DownLeft
			EnemySprite.flip_h = true
		velocity = target_position * speed
	move_and_slide()

func _process(delta):
	if velocity.length() > 0:
		$AlienAnimation.play()
	else:
		$AlienAnimation.frame = 4


func _on_detection_range_body_entered(body):
	if body.has_method("chase"):
		target = body

func _on_enemy_hitbox_body_entered(body):
	print(body)
	if body.has_method("hit"):
		emit_signal("playerHit")
		print("You have been hit!")
	if body.has_method("shot"):
		emit_signal("enemyHit")
		health -= 1
		if health == 0:
			queue_free()


