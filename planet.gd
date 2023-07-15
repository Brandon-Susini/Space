extends Area2D

@export var planet_stats: Resource
var selected = false
# Called when the node enters the scene tree for the first time.
func _ready():	
	for child in get_children():
		child.position = Vector2(planet_stats.orbit_distance,0)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(planet_stats.rotation_speed * delta)
	#var x = 0#sin(Time.get_ticks_msec())
	#var adj_offset = offset + x
	#sprite.position = Vector2(adj_offset,0)
	#collider.position = Vector2(adj_offset,0)
	
	
	pass
