extends Node

@export var meteor_speed: float
@export var meteor_scene: PackedScene
var distance_between_planets = 75
var planets
var path
# Called when the node enters the scene tree for the first time.
func _ready():
	path = $Path2D/PathFollow2D
	planets = $PlanetHolder
	var screen = get_viewport().get_visible_rect().size
	print(screen)
	planets.position = Vector2(screen.x/2,screen.y/2)
	#$PointLight2D.position = Vector2(screen.x/2,screen.y/2)
	
	
	
	var children = planets.get_children()
	for i in range(children.size()):
		children[i].set_rotation_point(planets.position)
		children[i].set_distance_from_point((i+1) * distance_between_planets)
		children[i].scale = Vector2(0.5,0.5)
		children[i].particles.amount = remap(children[i].distance_from_point, 0,1000,1,12)
		if children[i].distance_from_point < 100:
			children[i].particles.trail_enabled = false
			
		
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("rightClick"):
		spawn_meteor()
		#$ColorRect.color = Color(get_random_rgb_value(),get_random_rgb_value(),get_random_rgb_value(),1)
	pass


func get_random_rgb_value():
	return randi_range(0,255)

func spawn_meteor():
	path.progress_ratio = randf()
	var meteor = meteor_scene.instantiate()
	var direction = path.rotation
	direction += randf_range(-PI/4,PI/4)
	meteor.rotation = direction
	#meteor.get_node("GPUParticles2D").rotation = direction
	
	var velocity = Vector2(meteor_speed + randf_range(meteor_speed/4, meteor_speed/2),0)
	meteor.velocity = velocity.rotated(direction + PI/2)
	
	meteor.position = path.position
	add_child(meteor)
	
	
func _on_meteor_spawn_timer_timeout():
	spawn_meteor()
	pass # Replace with function body.
