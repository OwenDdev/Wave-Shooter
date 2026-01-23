extends Sprite2D

var speed = 150
var velocity = Vector2()

# preloading the bullet scence so it can be instanced by the player 
var bullet = preload("res://bullet.tscn")

var can_shoot = true
var is_dead = false

func _ready() -> void:
	Global.player = self

func _exit_tree() -> void:
	Global.player = null


func _process(delta: float) -> void:
	velocity.x = int(Input.is_action_pressed("move_right"))-int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down"))-int(Input.is_action_pressed("move_up"))
	
	# Maintain speed regardless of player direction
	velocity = velocity.normalized() 
	
	# Prevents Player for exceeding screen boundary
	global_position.x = clamp(global_position.x, 24, 616)
	global_position.y = clamp(global_position.y, 24, 336)
	
	if is_dead == false:
		global_position += speed * velocity * delta
	
	# On click instance bullet
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot and is_dead == false:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Reload_speed.start()
		can_shoot = false

func _on_reload_speed_timeout() -> void:
	can_shoot = true


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		is_dead = true
		visible = false
		await get_tree().create_timer(1).timeout
		get_tree().reload_current_scene()
		
		
