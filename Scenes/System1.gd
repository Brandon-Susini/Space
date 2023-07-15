extends Node

var distance_between_planets = 100
var planets
# Called when the node enters the scene tree for the first time.
func _ready():
	planets = $PlanetHolder
	var children = planets.get_children()
	for i in range(children.size()):
		
		children[i].set_distance_from_point((i+1) * distance_between_planets)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
