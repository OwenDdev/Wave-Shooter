extends Node2D

var enemy_1 = preload("res://enemy.tscn")

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
	
	Global.instance_node(enemy_1, enemy_position, self)
