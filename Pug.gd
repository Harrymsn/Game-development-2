extends KinematicBody2D



var jump = false
var velocity = Vector2()
onready var timer = get_node("Timer")
onready var timer2 = get_node("Timer2")
onready var GlobalTimer = get_node("../CanvasLayer3/Menu/timer")

func _ready():
	
	Jason.Dict["cantime"] = 1
	Jason.save_game()
	timer.start(1)
	yield(timer, "timeout")
	$"../CanvasLayer/change/AnimationPlayer".play("change")
	checkpoint()
	if Jason.Dict["tutorial"] == 0:
		if Jason.Dict["lang"] ==1:
			set_process(false)
			$"../CanvasLayer/press menu ita/AnimationPlayer".play("showm")
			yield($"../CanvasLayer/press menu ita/AnimationPlayer", "animation_finished")
			set_process(true)
		elif Jason.Dict["lang"] ==2:
			set_process(false)
			$"../CanvasLayer/press menu eng/AnimationPlayer".play("showm")
			yield($"../CanvasLayer/press menu eng/AnimationPlayer" , "animation_finished")
			set_process(true)
			
	Jason.Dict["tutorial"] =1
	Jason.save_game()
	

	
func _process(delta):
	var gravity = 10
	var jumpPower = -350
	velocity.y += gravity
	
	#var movement = speed *velocity.normalized()*delta
	
	
	
	
	
	if Input.is_key_pressed(KEY_LEFT) or Input.is_action_pressed("leftpad") && jump ==false:
		velocity.x  = -250
	elif Input.is_action_just_released("ui_left") or Input.is_action_just_released("leftpad") && jump ==false:
		velocity.x  = 0
		
	elif Input.is_key_pressed(KEY_RIGHT) or Input.is_action_pressed("rightpad") && jump ==false:
		velocity.x = 250
	elif Input.is_action_just_released("ui_right") or Input.is_action_just_released("rightpad") && jump ==false:
		velocity.x  =0
		
	if Input.is_action_just_pressed("ui_accept") && is_on_floor() && jump ==false:
		velocity.y = jumpPower
		
	elif Input.is_action_just_released("ui_accept") && not is_on_floor():
		$main.play("jump")
		
		
	
	move_and_slide(velocity, Vector2.UP)
	self.update_animation(velocity)
	
	
	if Jason.Dict["finish"] ==1:
		$"..".hide()
		$"../CanvasLayer2".hide()
		$"../CanvasLayer3".hide()
	

	


	
func update_animation(velocity):
	
	var jumpPower = -350
	if velocity.x  == -250:
		$main.play("walk")
		$main.scale.x = 0.2
		$CollisionPolygon2D.position = Vector2(-10,0)
	
	elif velocity.x  == 250:
		$main.play("walk")
		$main.scale.x = -0.2
		$CollisionPolygon2D.position = Vector2(0,0)
	elif velocity.x  == 0:
		$main.play("still")
		
	elif velocity.y != 0:
		$main.play("jump")
			 

func _on_mine_area_entered(area):
	if "spikes" in area.name: 
		die_spikes()
	elif "fall" in area.name:
		MusicManager.fall()
		relive()
	elif "moving" in area.name && is_on_floor():
		$".".get_floor_velocity()
	elif "one" in area.name:
		Jason.Dict["checkpoint"] = 2
		$"../check/fire".show()
		#print(Jason.Dict["timer"])
		Jason.save_game()
	elif "trans" in area.name:
		$"../CanvasLayer/CanvasLayer/change/AnimationPlayer".play("change")
		set_process(false)
		Jason.Dict["area"] =2
		Jason.Dict["music"] =2
		MusicManager.music()
		Jason.Dict["checkpoint"] = 3
		Jason.save_game()
		timer.start(2)
		yield(timer, "timeout")
		get_tree().change_scene("res://Level2.tscn")
	elif "sphere" in area.name:
		die_spikes()
	elif "active" in area.name:
		$"../KinematicBody2D".idle()
		$"../active".queue_free()
		
		
func relive():
	if Jason.Dict["lives"] !=1:
		$Camera2D.current = false
		Jason.Dict["lives"] -=1
		Jason.save_game()
		timer.start(4)
		yield(timer, "timeout")
		set_process(true)
		get_tree().change_scene("res://Level1.tscn")
	elif Jason.Dict["lives"] ==1:
		$Camera2D.current = false
		timer.start(1.5)
		yield(timer, "timeout")
		$"../CanvasLayer/change/AnimationPlayer".play_backwards("change")
		$"../CanvasLayer/Label".show()
		$"../CanvasLayer/change/AnimationPlayer".play("gameover")
		$Camera2D.current = true
		Jason.Dict["lives"] = 0
		Jason.Dict["music"] = 0
		Jason.Dict["area"] = 1
		Jason.Dict["checkpoint"] = 1
		Bigtimer.stoptime()
		Jason.save_game()
		timer.start(1.5)
		yield(timer, "timeout")
		get_tree().change_scene("res://Menu.tscn")
		
func die_spikes():
	if Jason.Dict["lives"] !=1:
		set_process(false)
		$main.play("die")
		$AnimationPlayer.play("fade")
		$Camera2D.current = false
		Jason.Dict["lives"] -=1
		Jason.save_game()
		timer.start(2)
		yield(timer, "timeout")
		set_process(true)
		get_tree().change_scene("res://Level1.tscn")
	elif Jason.Dict["lives"] ==1:
		set_process(false)
		$main.play("die")
		timer.start(1.5)
		yield(timer, "timeout")
		$"../CanvasLayer/change/AnimationPlayer".play_backwards("change")
		$"../CanvasLayer/Label".show()
		$"../CanvasLayer/change/AnimationPlayer".play("gameover")
		$Camera2D.current = true
		Jason.Dict["lives"] = 0
		Jason.Dict["music"] = 0
		Jason.Dict["checkpoint"] = 1
		Jason.Dict["area"] = 1
		Jason.Dict["key"] = 0
		Bigtimer.stoptime()
		Jason.save_game()
		timer.start(3)
		yield(timer, "timeout")
		get_tree().change_scene("res://Menu.tscn")
	
		
func checkpoint():
	Jason.load_game()
	if Jason.Dict["checkpoint"] == 1:
		self.position = Vector2(590,500)
		set_process(true)
	elif Jason.Dict["checkpoint"] == 2:
		self.position = Vector2(4580,-930)
		set_process(true)


func jump():
	jump= true
	$main.play("jump")
	timer.start(1.5)
	yield(timer, "timeout")
	jump= false

