extends CharacterBody2D

signal damage
@export var speed : int = 25
@export var health : int = 3
@onready var hit_timer = $impactTimer
@onready var despawn_timer = $despawnTimer
var target_position
var target = null
var rotationDir : float
var status = true

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	if target != null and status == true:
		target_position = (target.position - self.position).normalized()
		rotationDir = atan2(target_position.y, target_position.x)
		if rotationDir > (-1*PI/2) and rotationDir < PI/2: #Looking right
			$Sprite2D.flip_h = false
		elif rotationDir < PI and rotationDir > (-1*PI): #Looking left
			$Sprite2D.flip_h = true
		velocity = target_position * speed
	else:
		velocity = Vector2(0,0)
	move_and_slide()

func _process(delta):
	if velocity.length() > 0 and status == true:
		$Sprite2D/AnimationPlayer.current_animation = "movement"
		$Sprite2D/AnimationPlayer.play()
	elif status == true:
		$Sprite2D.frame = 4

func _on_detection_range_body_entered(body):
	target = body

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("hit") and status == true:
		emit_signal("damage", rotationDir)
	if body.has_method("shot") and status == true:
		print("hit")
		$Sprite2D.modulate = "FE3E3E"
		speed = -25
		hit_timer.start()
		health -= 1
		if health == 0:
			status = false
			despawn_timer.start()
			$Sprite2D/AnimationPlayer.current_animation = "death"
			$Sprite2D/AnimationPlayer.play()

func _on_hit_timer_timeout():
	$Sprite2D.modulate = "b5b5b5"
	speed = 25
	
func _on_despawn_timer_timeout():
	$Sprite2D.frame = 4
	self.queue_free()
