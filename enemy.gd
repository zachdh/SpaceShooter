extends CharacterBody2D

@export var speed = 25
@export var health : int = 3
@onready var hit_timer = $impactTimer
@onready var despawn_timer = $despawnTimer
@onready var target_node = get_node("/root/Main/player")
var target_position
var target = null
var rotationDir : float
var status = true
var nav_agent 

func _ready():
	nav_agent = $Navigation/NavigationAgent2D
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4


func _physics_process(_delta):
	#tells the enemy where to move to based on the direciton of the next point on the path.
	if nav_agent.is_navigation_finished():
		return
	else:
		var axis = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = axis * speed
	move_and_slide()
	
	#flips the sprite horizontally based on the direction the enemy is looking
	target_position = target_node.global_position
	rotationDir = atan2(target_position.y, target_position.x)
	if rotationDir > (-1*PI/2) and rotationDir < PI/2: #Looking right
		$Sprite2D.flip_h = false
	elif rotationDir < PI and rotationDir > (-1*PI): #Looking left
		$Sprite2D.flip_h = true
		

	
#recalculates the path to the players current position from the previous position
func recalc_path():
	nav_agent.target_position = target_node.global_position

func _on_recalculate_timer_timeout():
	recalc_path()

func _process(delta):
	if velocity.length() > 0 and status == true:
		$Sprite2D/AnimationPlayer.current_animation = "movement"
		$Sprite2D/AnimationPlayer.play()
	elif status == true:
		$Sprite2D.frame = 4

func _on_hit_timer_timeout():
	$Sprite2D.modulate = "b5b5b5"
	speed = 25
	
func _on_despawn_timer_timeout():
	$Sprite2D.frame = 4
	self.queue_free()
	
#func _on_enemy_hitbox_body_entered(body):
#	if body.has_method("shot") and status == true:
#		print("hit")
#		$Sprite2D.modulate = "FE3E3E"
#		speed = -25
#		hit_timer.start()
#		health -= 1
#		if health == 0:
#			status = false
#			despawn_timer.start()
#			$Sprite2D/AnimationPlayer.current_animation = "death"
#			$Sprite2D/AnimationPlayer.play()


	


	
	








