extends Node

@export var meteor_speed: float
@export var meteor_scene: PackedScene
var distance_between_planets = 150

var planet_names = ["oil","earth"]
var sun
var path
var areDonuts = false
# Called when the node enters the scene tree for the first time.
func _ready():
	path = $Path2D/PathFollow2D
	sun = $Sun
	var screen = get_viewport().get_visible_rect().size
	print(screen)
	sun.position = Vector2(screen.x/2,screen.y/2)
	#$PointLight2D.position = Vector2(screen.x/2,screen.y/2)
	
	
	
	var children = sun.get_children().filter(func(node): return node.is_class("Area2D"))
	for i in range(children.size()):
		children[i].set_rotation_point(sun.position)
		children[i].set_distance_from_point((i+1) * distance_between_planets)
		#children[i].scale = Vector2(0.5,0.5)
		children[i].particles.amount = remap(children[i].distance_from_point, 0,1000,1,12)
		if children[i].distance_from_point < 100:
			children[i].particles.trail_enabled = false
		children[i].get_node("AnimatedSprite2D").animation = planet_names[i%2]
		children[i].get_node("AnimatedSprite2D").play()	
		
		



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
	var meteor_sprite = meteor.get_node("AnimatedSprite2D")
	meteor_sprite.animation="donuts"
	meteor_sprite.frame = (randi() % 8)
	
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
