extends CharacterBody2D

var speed = 120
var turn_speed = 4.5 
var lastvel = Vector2.ZERO

func _ready():
	$Animations.play("idle")
	
func player_movement(delta):
	var turn_direction = Input.get_axis("left", "right")
	rotation += turn_direction * turn_speed * delta
	var move_direction = Input.get_axis("up", "down")

	if move_direction != 0:
		velocity = transform.y * move_direction * speed
		lastvel = velocity
	else:
		velocity = Vector2.ZERO
	
func idle_animation():
	if velocity == Vector2.ZERO:
		$Animations.play("idle")
		
func movement_animation():
	if velocity != Vector2.ZERO:
		$Animations.play("run")

func _physics_process(delta):
		player_movement(delta) 
		
		if velocity == Vector2.ZERO:
			idle_animation()
		else:
			movement_animation()
			
		move_and_slide()

# frame perfect / footsteps
func _on_animations_frame_changed():
	if $Animations.animation == "run":
		if $Animations.frame in [1, 3, 5, 7]:
			$Footsteps.play()
	else:
		$Footsteps.stop()
