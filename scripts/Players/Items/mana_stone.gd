extends Node2D

var ongoing = false

var Item = preload("res://scenes/Players/Items/item.tscn")
var icon = preload("res://assets/tile.png")
var obj_sprite = preload("res://assets/tile.png")
var slot = null
var uses
var grade

var cooldown = 0
var entered = false

var active

onready var inventory = get_node("/root/Main/Player/HUD/Player_UI/inventory")

func _ready():
	randomize()
	var rng = randf()
	if rng < 0.1:
		grade = 2
	elif rng < .3:
		grade = 1
	else:
		grade = 0
	_assign_values()

func _assign_values():
	var uses_array = [1, 2, 3]
	uses = uses_array[grade]

func _activate(b):
	active = b

func spend():
	_update_uses()

func _use(player):
	print("test")
	player.mana += 10
	if player.mana > 30:
		player.mana = 30
	_update_uses()

func _update_uses():
	uses -= 1
	slot._update()
	if uses <= 0:
		slot._empty()
		queue_free()

func _materialize(pos):
	var item = Item.instance()
	add_child(item)
	global_position = pos
