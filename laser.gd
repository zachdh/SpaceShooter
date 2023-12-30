extends StaticBody2D

@export var speed : int = 10
@onready var kill_timer = $KillTimer

var direction := Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	kill_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity
		
func set_direction(direction: Vector2):
	self.direction = direction
	
func shot():
	pass

func _on_kill_timer_timeout() -> void:
	queue_free()

