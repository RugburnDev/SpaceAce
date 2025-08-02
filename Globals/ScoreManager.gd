extends Node


var score: int = 0:
	get: return score


var high_score: int = 0:
	get: return high_score


func increment_score(v: int) -> void:
	score += v
	if high_score < score:
		high_score = score
	SignalHub.emit_on_score_updated(score)
	

func reset_score():
	score = 0
	SignalHub.emit_on_score_updated(score)
