# Singleton
extends Node

var node_creation_parent = null
var player = null
var camera = null

var points = 0
var Highscore = 0


func instance_node(node, location, parent):
	var node_instance = node.instantiate() 
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func save():
	var save_dict = {
		"highscore": Highscore
	}
	return save_dict
	
func save_game():
	var save_game = FileAccess.open_encrypted_with_pass("user://savegme.save", FileAccess.WRITE, "enc")
	save_game.store_line(JSON.stringify(save()))
	save_game.close()
	
func load_game():
	if not FileAccess.file_exists("user://savegme.save"):
		print("Error! We dont have a save file to load")
		return
		
	var save_game = FileAccess.open_encrypted_with_pass("user://savegme.save", FileAccess.READ, "enc")
	
	var current_line = JSON.parse_string(save_game.get_line())
	
	Highscore = current_line["highscore"]
	save_game.close
