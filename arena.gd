extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.node_creation_parent = self
	
func _exit_tree() -> void:
	Global.node_creation_parent = null
