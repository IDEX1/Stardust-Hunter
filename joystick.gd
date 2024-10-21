extends Area2D

@onready var big_circle = $big_circle
@onready var small_circle = $big_circle/small_circle
@onready var max_distance = $CollisionShape2D.shape.radius

var touched = false

func _input(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			var distance = event.position.distance_to(big_circle.global_position)
			if distance < max_distance:
				touched = true
		else:
			touched = false
			small_circle.position = Vector2(0, 0)

func _process(delta):
	if touched:
		var new_position = get_global_mouse_position()
		var distance = new_position.distance_to(big_circle.global_position)

		if distance > max_distance:
			var direction = (new_position - big_circle.global_position).normalized()
			small_circle.global_position = big_circle.global_position + direction * max_distance
		else:
			small_circle.global_position = new_position


func get_velo():
	var joy_velo = Vector2(0,0)
	joy_velo.x = small_circle.position.x / max_distance
	joy_velo.y = small_circle.position.y / max_distance
	return joy_velo
