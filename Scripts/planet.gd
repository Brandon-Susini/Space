extends Area2D

@export var origin: Node
@export var planet_stats: Resource
var rotation_point
var distance_from_point = 100
var current_angle = 0
var selected = false
var mat

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set the origin point to rotate around
	if origin:
		rotation_point = origin.position
	else:
		var screen = get_viewport().get_visible_rect().size
		rotation_point = Vector2(screen.x/2,screen.y/2)
	mat = $GPUParticles2D.process_material
	mat.initial_velocity_min = planet_stats.particle_velocity
	mat.initial_velocity_max = mat.initial_velocity_min + planet_stats.particle_velocity_range
	
	
	#$Sprite.texture = planet_stats.donut_frames.get_frame_texture("donuts", randi() % 8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = rotation_point
	global_position += Vector2(cos(current_angle), sin(current_angle)) * distance_from_point
	current_angle += planet_stats.rotation_speed * delta
	
	
func set_distance_from_point(d: float):
	distance_from_point = d
