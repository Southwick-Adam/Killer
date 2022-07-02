extends Node2D

var type = 0

onready var inventory = get_node("/root/Main/Player/HUD/Player_UI/inventory")

var entered = false

var connections = []
var rng = RandomNumberGenerator.new()

func _ready():
	pass

func _entered(b):
	$Area2D/Sprite/light.visible = b
	entered = b

func _on_TouchScreenButton_pressed():
	if entered:
		_test()

func _test():
	if inventory.active_item != null:
		if inventory.active_item.is_in_group("mana_stone"):
			inventory.active_item._use()
		_activate()

func _connect():
	for portal in get_tree().get_nodes_in_group("portal"):
		if portal.type == type and portal != self:
			connections.append(portal)

func _activate():
	if connections.empty():
		_connect()
	rng.randomize()
	var destination = connections[rng.randi_range(0,connections.size() - 1)]
	get_node("/root/Main/Player/body").global_position = destination.global_position
