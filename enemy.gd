extends Sprite2D

var speed = 75

var velocity = Vector2()

var stun = false
var hp = 3

func _process(delta: float) -> void:
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(Global.player.global_position)
	# smoothes the knockback
	elif stun:
		velocity = lerp(velocity, Vector2(0,0), 0.3)
		
	global_position += velocity * speed * delta
	
	if hp <= 0:
		queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy_damager"):
		modulate = Color.WHITE
		#basic knockback
		velocity = -velocity * 6
		hp -= 1
		stun = true
		$Stun_timer.start()
		area.get_parent().queue_free()


func _on_stun_timer_timeout() -> void:
	modulate = Color("f9133e")
	stun = false
