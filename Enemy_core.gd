extends Sprite2D

@export var speed : int = 75

var velocity = Vector2()

var stun = false
@export var hp : int = 3
@export var knockback : int = 600
@export var screenshake : int = 120

@onready var current_color = modulate

var blood_particles = preload("res://blood_particles.tscn")

func _process(delta: float) -> void:
	if hp <= 0:
		if Global.camera  != null:
			Global.camera.screen_shake(screenshake, 0.2)
		
		Global.points += 10
		if Global.node_creation_parent != null:
			var blood_particles_instance =  Global.instance_node(blood_particles, global_position, Global.node_creation_parent)
			blood_particles_instance.rotation = velocity.angle()
		queue_free()

func basic_movement_towards_player(delta):
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(Global.player.global_position)
		global_position += velocity * speed * delta
	# smoothes the knockback
	elif stun:
		velocity = lerp(velocity, Vector2(0,0), 0.3)
		global_position += velocity * delta
	
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy_damager") and stun == false:
		modulate = Color.WHITE
		#basic knockback
		velocity = -velocity * knockback
		hp -= 1
		stun = true
		$Stun_timer.start()
		area.get_parent().queue_free()

func _on_stun_timer_timeout() -> void:
	#modulate = Color("f9133e")
	modulate = current_color
	stun = false
