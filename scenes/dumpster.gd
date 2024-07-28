extends Area2D

signal surrender_inventory

var inventory = []

func create_inventory():
	inventory.append("cockroach")
	inventory.append("moldy_bread")
	inventory.append("mystery_sauce")

# Called when the node enters the scene tree for the first time.
func _ready():
	create_inventory()

func _on_body_entered(body):
	emit_signal("surrender_inventory", inventory)
	queue_free()
