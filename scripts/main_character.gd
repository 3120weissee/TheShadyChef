extends CharacterBody2D

@export var speed = 100

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
