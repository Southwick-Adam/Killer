extends Node2D

onready var player = get_node("/root/Main/Player")

func _process(_delta):
	var mana = player.mana
	$bar.scale.x = mana / player.max_mana
	if mana >= 10:
		$Sprite.visible = true
	else:
		$Sprite.visible = false
	if mana >= 20:
		$Sprite2.visible = true
	else:
		$Sprite2.visible = false
	if mana >= 30:
		$Sprite3.visible = true
	else:
		$Sprite3.visible = false
		
