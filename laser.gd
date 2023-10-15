extends StaticBody2D

@export var speed : int = 10

var direction := Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity
		
func set_direction(direction: Vector2):
	self.direction = direction
	
func shot():
	pass
	
func _on_alien_enemy_enemy_hit():
	print("laser hit enemy")
	queue_free()
