extends Area2D

@export var origin: Node
@export var planet_stats: Resource
var distance_from_point = 100
var current_angle = 0
var selected = false

var rotation_point
var rotation_speed_mult
var particles
var mat

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set the origin point to rotate around
	if origin:
		rotation_point = origin.position
	else:
		var screen = get_viewport().get_visible_rect().size
		rotation_point = Vector2(screen.x/2,screen.y/2)
	particles = $GPUParticles2D
	mat = particles.process_material
	#$AnimatedSprite2D.play()
	#particles.amount = remap()
	#mat.initial_velocity_min = planet_stats.particle_velocity
	#mat.initial_velocity_max = mat.initial_velocity_min + planet_stats.particle_velocity_range
	
	rotation_speed_mult = randf_range(0.8, 1.3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = rotation_point
	global_position += Vector2(cos(current_angle), sin(current_angle)) * distance_from_point
	current_angle += (planet_stats.rotation_speed * rotation_speed_mult) * delta
	#rotate(position.angle_to(global_position))
	particles.look_at(rotation_point)
	particles.rotate(-PI/2)
	
func set_distance_from_point(d: float):
	distance_from_point = d


func set_rotation_point(point: Vector2):
	rotation_point = point


func get_random_donut():
	return planet_stats.donut_frames.get_frame_texture("donuts", randi() % 8)
	pass
