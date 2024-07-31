extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func randomizeScale():
	var size = randf_range(0.75,2.0)
	%UFOSprite.scale = Vector2(2.5-size,2.5-size)
	%UFOLight.scale = Vector2(size,size)
	%Detection.scale = Vector2(size,size)
