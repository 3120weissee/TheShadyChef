extends Node2D

@export var mob_scene: PackedScene
@export var mainCharacter: PackedScene
var mobCounter = 0
var start_position: Vector2 = Vector2(641,452)

# Called when the node enters the scene tree for the first time.
func _ready():
	#start_game()
	%AnimateCamera.play("opening_camera")
	
func start_game():
	%StartMenu.hide()
	%AnimateCamera.stop()
	%MobTimer.start()
	createMainCharacter()
	
func game_over(score):
	%OpeningCamera.make_current()
	%AnimateCamera.play("opening_camera")
	var final_score = int(score * 100)
	final_score += (mobCounter * 5)
	%Score.text = str(final_score)
	%GameOver.show()
	
func reset_game():
	mobCounter = 0
	%MobTimer.stop()
	%MobTimer.wait_time = 1.0
	get_tree().call_group("ufos", "queue_free")
	%GameOver.hide()
	%StartMenu.show()

func createMainCharacter():
	var chef = mainCharacter.instantiate()
	chef.position = start_position
	add_child(chef)
	chef.connect("game_over",self.game_over)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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


func _on_start_game_pressed():
	start_game()


func _on_continue_pressed():
	reset_game()
	
