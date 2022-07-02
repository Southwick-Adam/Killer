extends Node2D

var set = false

func _on_settings_pressed():
	if set:
		$music.visible = false
		$sound.visible = false
	else:
		$music.visible = true
		$sound.visible = true
	set = !set

func _on_minimap_pressed():
	var map = get_node("/root/Main/Player/HUD/MiniMap")
	map.visible = !map.visible

func _on_music_pressed():
	pass # Replace with function body.

func _on_sound_pressed():
	pass # Replace with function body.
