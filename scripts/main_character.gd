extends CharacterBody2D

@export var speed = 100
@export var player_inventory = []

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	animate_character(input_direction[0],input_direction[1])
	
	velocity = input_direction * speed

func _physics_process(_delta):
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
