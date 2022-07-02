extends Node2D

onready var player = get_node("/root/Main/Player")

func _process(_delta):
	$back/Sprite.scale.x = player.health / player.max_health
