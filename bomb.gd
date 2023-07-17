extends CharacterBody2D


var speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Spawned Meteor")
	#velocity = Vector2.RIGHT * speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	print("Meteor despawned")
	queue_free()
	pass # Replace with function body.
