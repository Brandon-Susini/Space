extends Resource
class_name PlanetResource

@export var rotation_speed: float
@export var particle_velocity: float
@export var particle_velocity_range: float
@export_enum("Sphere","Ring","Point") var emission_shape: String
@export var orbit_distance: float
@export var particle_color: Vector3
@export var particle_spread: float

@export var donut_frames: SpriteFrames
