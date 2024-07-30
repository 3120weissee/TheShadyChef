extends Node2D

@export var mob_scene: PackedScene
var mobCounter = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	%MobTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mob_timer_timeout():
		var mob = mob_scene.instantiate()
		
		var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
		mob_spawn_location.progress_ratio = randf()
		
		var direction = mob_spawn_location.rotation + PI / 2
		
		mob.position = mob_spawn_location.position
		mob.randomizeScale()
		
		direction += randf_range(-PI / 4, PI / 4)
		
		var velocity = Vector2(randf_range(100.0,150.0), 0.0)
		mob.linear_velocity = velocity.rotated(direction)
		
		add_child(mob)
		mobCounter += 1
		
		updateMobTimer(mobCounter)

func updateMobTimer(count):
	var waitTime = %MobTimer.wait_time
	if waitTime > .20:
		if count % 10 == 0:
			%MobTimer.wait_time -= .02
