extends Node2D

var SPEED = 200
const ACCELERATION = 0.4
var velocity = Vector2()

var sprite_scale = 1
var current_room

var omen = []
var item = []

var health = 100
var max_health = 100

var mana = 0
var max_mana = 30

func _change_rooms(room):
	current_room = room
	$Shadow.global_position = room.global_position
	$HUD/MiniMap._update_player(room)

func _animate(anim):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)

func _process(_delta):
	if Input.is_action_pressed("ui_up"):
		velocity.y = lerp(velocity.y, -SPEED, ACCELERATION)
	elif Input.is_action_pressed("ui_down"):
		velocity.y = lerp(velocity.y, SPEED, ACCELERATION)
	else:
		velocity.y = lerp(velocity.y, 0, ACCELERATION)
	if Input.is_action_pressed("ui_left"):
		$body/Sprite.scale.x = -sprite_scale
		velocity.x = lerp(velocity.x, -SPEED, ACCELERATION)
	elif Input.is_action_pressed("ui_right"):
		$body/Sprite.scale.x = sprite_scale
		velocity.x = lerp(velocity.x, SPEED, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0, ACCELERATION)
	velocity = $body.move_and_slide(velocity, Vector2(0,-1))
#Animations
	if abs(velocity.x) > 70 or abs(velocity.y) > 70:
		#_animate("run")
		pass
	else:
		#_animate("idle")
		pass

func _input(_event):
	pass

func _on_area_area_entered(area):
	var obj = area.get_parent()
	if obj.is_in_group("omen"):
		omen.append(obj)
		obj._entered(true)
	elif obj.is_in_group("item"):
		item.append(obj)
		obj._entered(true)

func _on_area_area_exited(area):
	var obj = area.get_parent()
	if obj.is_in_group("omen") and omen.has(obj):
		omen.erase(obj)
		obj._entered(false)
	if obj.is_in_group("item") and item.has(obj):
		item.erase(obj)
		obj._entered(false)

func _on_TouchScreenButton_pressed():
	if $HUD/Player_UI/inventory.active_item != null:
		if $HUD/Player_UI/inventory.active_item.is_in_group("affect_player"):
			print($HUD/Player_UI/inventory.active_item.name)
			$HUD/Player_UI/inventory.active_item._use(self)

func _on_TouchScreenButton_released():
	if $HUD/Player_UI/inventory.active_item != null:
		if $HUD/Player_UI/inventory.active_item.is_in_group("affect_player"):
			if $HUD/Player_UI/inventory.active_item.ongoing:
				$HUD/Player_UI/inventory.active_item._stop(self)
