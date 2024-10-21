extends CharacterBody2D

@export var max_speed = 250  # max speed when joystick is max pushed
@export var acceleration = 10  # acceleration for smoother rocket movement
@export var damping = 5  # damping to slow down when not moving 
@export var rotation_speed = 5  # rotation speed for smoother rotation

func _physics_process(delta):
	# get the joystick velocity
	var joystick_velocity = $ui/joystick.get_velo()
	
	# check if there is input
	if joystick_velocity.length() > 0:
		# calculate the speed based on the joystick movement
		var target_velocity = joystick_velocity * max_speed * joystick_velocity.length()
		velocity = velocity.lerp(target_velocity, acceleration * delta)
		
		# calculate target rotation based on joystick direction
		var target_rotation = joystick_velocity.angle()
		
		# smoothly rotate towards the target rotation
		rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)
	else:
		# apply damping to slow down when joystick is released
		velocity = velocity.lerp(Vector2.ZERO, damping * delta)
	
	# move
	move_and_slide()
