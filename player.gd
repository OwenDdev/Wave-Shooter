extends Sprite2D

var speed = 150
var velocity = Vector2()

func _process(delta: float) -> void:
	velocity.x = int(Input.is_action_pressed("move_right"))-int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down"))-int(Input.is_action_pressed("move_up"))
	
	# Maintain speed regardless of player direction
	velocity = velocity.normalized() 
	
	
	global_position += speed * velocity * delta
