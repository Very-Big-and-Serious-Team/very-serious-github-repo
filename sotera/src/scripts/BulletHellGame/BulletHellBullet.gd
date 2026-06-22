extends Node2D
class_name BulletHellBullet

@export var lifetime:float
@export var speed:float


var state:BULLETSTATE = BULLETSTATE.DISABLED

enum BULLETSTATE{
	SHOOTING,
	DISABLED
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if state == BULLETSTATE.SHOOTING:
		position+= transform.x*speed*delta

func shoot(mousePos:Vector2)->void:
	$Sprite.show()
	look_at(mousePos)
	state = BULLETSTATE.SHOOTING
	$Lifetime.start(lifetime)
	
func disable()->void:
	state = BULLETSTATE.DISABLED
	position = Vector2.ZERO
	$Sprite.hide()


func _on_hit_area_entered(body: Node2D) -> void:
	if body.is_in_group("BulletHellEnemy"):
		#Do enemy hurt
		disable()
		pass
