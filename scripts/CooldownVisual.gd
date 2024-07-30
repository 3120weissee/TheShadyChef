extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	value = (%DisguiseCooldown.time_left / 3) * 100


func _on_disguise_cooldown_timeout():
	hide()


func _on_disguise_duration_timeout():
	show()
