# helper function holder class
class_name TweenUtils

static func ease_out_quart(x: float) -> float: # [0, 1]
	return 1.0 - pow(1.0 - x, 4.0)

# Dummy constructor to prevent idiots calling .new()
func _init() -> void:
	assert(false, "Use TweenUtils.target_function() instead")


static func ease_in_out_elastic(x: float) -> float:
	var c5: float = (2.0 * PI) / 4.5

	if x == 0.0:   return 0.0
	elif x == 1.0: return 1.0
	elif x < 0.5:  return -(pow(2.0, 20.0 * x - 10.0) * sin((20.0 * x - 11.125) * c5)) / 2.0
	else: 		   return (pow(2.0, -20.0 * x + 10.0) * sin((20.0 * x - 11.125) * c5))
