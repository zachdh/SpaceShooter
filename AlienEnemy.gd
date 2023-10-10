extends StaticBody2D

var detection_area: Area2D


func _ready():
	detection_area = $Area2D
	detection_area.connect("area_entered", self, "_on_area_2d_area_entered")



func _on_area_2d_area_entered(area):
	if area.is_in_group("CharacterBody2D"):
		# Player entered the detection area, start chasing or perform actions.
		print("Player detected!")



