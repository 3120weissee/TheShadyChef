extends CharacterBody2D

@export var speed = 100
@export var player_inventory = []
var detections = 0
var isDisguised = false
var isOnCooldown = false
var elapsed_time = 0.0

signal game_over

func _ready():
	%MainCamera.make_current()

func get_input():
	if Input.is_action_just_pressed("interact") && !isOnCooldown:
		disguise()
		velocity = Vector2(0,0)
	elif !isDisguised:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		animate_character(input_direction[0],input_direction[1])
		
		velocity = input_direction * speed

func _physics_process(delta):
	if !isDisguised:
		elapsed_time += delta
	get_input()
	move_and_slide()

func animate_character(x,y):
	if x > 0:
		%CharacterAnimation.play('walk_right')
	elif x < 0:
		%CharacterAnimation.play('walk_left')
	elif y > 0:
		%CharacterAnimation.play('walk_down')
	elif y < 0:
		%CharacterAnimation.play('walk_up')
	else:
		%CharacterAnimation.stop()

func _on_dumpster_surrender_inventory(dumpster_inventory):
	player_inventory += dumpster_inventory
	print(player_inventory)

func _on_detection_area_entered(_area):
	detections += 1
	isGameOver()
	
func _on_detection_area_exited(_area):
	detections -= 1
	
func disguise():
	if isDisguised:
		%DumpsterSprite.hide()
		$CharacterSprite.show()
		%DisguiseDuration.stop()
		%DurationVisual.hide()
	else:
		%DumpsterSprite.show()
		$CharacterSprite.hide()
		%DisguiseDuration.start()
		%DurationVisual.show()
	
	isDisguised = !isDisguised
	if detections > 0:
		isGameOver()

func isGameOver():
	if detections > 0 && !isDisguised:
		emit_signal("game_over", elapsed_time)
		queue_free()


func _on_disguise_duration_timeout():
	disguise()
	cooldown()
	
func cooldown():
	isOnCooldown = true
	%DisguiseCooldown.start()

func _on_disguise_cooldown_timeout():
	isOnCooldown = false
