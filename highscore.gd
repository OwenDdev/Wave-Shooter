extends Label


func _ready() -> void:
	Global.load_game()
	text = str(Global.Highscore)
	
func _process(delta: float) -> void:
	if Global.points > Global.Highscore:
		Global.Highscore = Global.points
