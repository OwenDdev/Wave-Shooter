extends Node2D

@export var enemies: Array[PackedScene] 
@export var power_ups: Array[PackedScene] 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.node_creation_parent = self
	
	Global.points = 0
	
func _exit_tree() -> void:
	Global.node_creation_parent = null
	
func _on_enemy_spawn_timer_timeout() -> void:
	var enemy_position = Vector2(randf_range(-160, 670), randf_range(-90, 390))
	
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.x < 360 and enemy_position.y > -45:
		enemy_position = Vector2(randf_range(-160, 670), randf_range(-90, 390))
	
	var enemy_number = round(randi_range(0, enemies.size() - 1))
	
	Global.instance_node(enemies[enemy_number], enemy_position, self)
	# Exponential difficulty curve
	#$Enemy_spawn_timer.wait_time *= 0.95


func _on_difficulty_timer_timeout() -> void:
	if $Enemy_spawn_timer.wait_time > 0.5:
		$Enemy_spawn_timer.wait_time -= 0.025


func _on_power_up_spawn_timer_timeout() -> void:
	var power_up_number = round(randi_range(0, power_ups.size() - 1))
	
	Global.instance_node(power_ups[power_up_number], Vector2(randi_range(0, 640), randi_range(0, 360)), self)
