extends Control


onready var GlobalTimer = get_node("CanvasLayer3/Menu/timer/Label")
onready var timer2 = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	Jason.load_game()



func _process(_delta):
	
	
	if Input.is_key_pressed(KEY_M) and Jason.Dict["menu"] ==0 or Input.is_action_just_pressed("menu") and Jason.Dict["menu"] ==0:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  
		$"../../Sprite".set_process(false)
		#Cursor.show()
		print(Jason.Dict["menu"])
		timer2.start(0.1)
		yield(timer2, "timeout")
		Jason.Dict["menu"] =1
		$".".show()
		$timer/Label.show()
		if Jason.Dict["lang"] ==1:
			$"close/close ita".show()
			$"settings/settings ita".show()
			$"quit/quit ita".show()
			$"controls/settings ita".show()
		elif Jason.Dict["lang"] ==2:
			$"close/close eng".show()
			$"settings/settings eng".show()
			$"controls/settings eng".show()
			$"quit/quit eng".show()
		
	elif Input.is_key_pressed(KEY_M) and Jason.Dict["menu"] ==1 or Input.is_action_just_pressed("menu") and Jason.Dict["menu"] ==1:
		$"../../Sprite".set_process(true)
		timer2.start(0.1)
		yield(timer2, "timeout")
		Jason.Dict["menu"] =0
		print(Jason.Dict["menu"])
		#Cursor.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)  
		$".".hide()
		$timer/Label.hide()
		if Jason.Dict["lang"] ==1:
			$"close/close ita".hide()
			$"settings/settings ita".hide()
			$"quit/quit ita".hide()
			$"controls/settings ita".hide()
		elif Jason.Dict["lang"] ==2:
			$"close/close eng".hide()
			$"settings/settings eng".hide()
			$"quit/quit eng".hide()
			$"controls/settings eng".hide()
		


func _on_close_pressed():
	$".".hide()
	$"../../Sprite".set_process(true)
	timer2.start(0.1)
	yield(timer2, "timeout")
	Jason.Dict["menu"] =0
	print(Jason.Dict["menu"])
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)  


func _on_settings_pressed():
	$".".hide()
	$"../settings".show()
	if Jason.Dict["lang"] ==1:
		$"../settings/settings ita".show()
		$"../settings/close/close ita".show()
		$"../settings/close2/adjust ita".show()
		
	elif Jason.Dict["lang"] ==2:
		$"../settings/settings eng".show()
		$"../settings/close/close eng".show()
		$"../settings/close2/adjust eng".show()


func _on_yes_pressed():
	if Jason.Dict["checkpoint"] ==1:
		Jason.Dict["timer"] = 0
	Jason.Dict["cantime"] = 0
	Jason.save_game()
	get_tree().change_scene("res://Menu.tscn")
	


func _on_no_pressed():
	$"../quit".hide()
	$"../yes/yes".hide()
	$"../yes/si".hide()
	
	$"../no/no".hide()
	$"../escita".hide()
	$"../esceng".hide()
	$".".show()


func _on_quit_pressed():
	if Jason.Dict["lang"] ==1:
		$"../escita".show()
		$"../yes/si".show()
		$"../no/no".show()
		$".".hide()
		$"../quit".show()
	elif Jason.Dict["lang"] ==2:
		$"../esceng".show()
		$"../yes/yes".show()
		$"../no/no".show()
		$".".hide()
		$"../quit".show()
	
		
	
	
	



func _on_controls_pressed():
	$".".hide()
	$"../controls".show()
	if Jason.Dict["lang"] ==1:
		$"../controls/move ita".show()
		$"../controls/jump ita".show()
		$"../controls/controls ita".show()
		$"../controls/close/close ita".show()
	elif Jason.Dict["lang"] ==2:
		$"../controls/move eng".show()
		$"../controls/jump eng".show()
		$"../controls/controls eng".show()
		$"../controls/close/close eng".show()
