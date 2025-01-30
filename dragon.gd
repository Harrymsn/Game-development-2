extends KinematicBody2D



onready var timer = get_node("Timer")
onready var timer2 = get_node("Timer2")
# Called when the node enters the scene tree for the first time.
func _ready():
	$sphere/sphere.modulate = Color(0.862745, 0.0784314, 0.235294, 1)



func _process(delta):
	pass


func idle():
	$AnimatedSprite.play("fly")
	$sphere.hide()
	timer.start(1)
	yield(timer, "timeout")
	attack()
func attack():
	if timer2.time_left ==0:
		timer2.start()
		$AnimatedSprite.play("attack")
		yield($AnimatedSprite, "animation_finished")
		$sphere.show()
		timer.start(1)
		yield(timer, "timeout")
		MusicManager.shoot()
		sphere()
		idle()

func sphere():
	var sphere = load("res://sphere.tscn")
	var spherez = sphere.instance()
	
	
	get_node("/root/Level3").add_child(spherez)
	spherez.modulate = Color(0.862745, 0.0784314, 0.235294, 1)
	spherez.position = self.position + $raycast.cast_to.normalized()*50
	spherez.apply_impulse(Vector2(), $raycast.cast_to.normalized()*1300)
	spherez.set_angular_velocity(300)
	
