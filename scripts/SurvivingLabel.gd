extends Label

var elapsed_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _format_time(time): 
	var minutes = time / 60
	var seconds = fmod(time, 60)
	return "%02d:%02d" % [minutes, seconds]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed_time += delta
	text = _format_time(elapsed_time)
