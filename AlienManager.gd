extends Node2D
@export var Alien : PackedScene
var spawnpoints : Array = [Vector2(-430,-150), Vector2(300,-150), Vector2(700,350)]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn(alien, location):
	alien.set_position(location)
	add_child(alien)


func _on_alien_spawn_timer_timeout():
	var alien_instance = Alien.instantiate()
	var spawnpoint = spawnpoints.pick_random()
	spawn(alien_instance, spawnpoint)
	
