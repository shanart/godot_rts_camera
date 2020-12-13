extends Spatial

# EXPORT PARAMS
export (float, 0, 1000) var movement_speed

# Overwrite functions
func _process(delta: float) -> void:
	_move(delta)
	
# movement functions
func _move(delta: float) -> void:
	# initialize velocity vector
	var velocity = Vector3()
	
	# populated it
	if Input.is_action_pressed("camera_forward"):
		velocity -= transform.basis.z
	if Input.is_action_pressed("camera_backward"):
		velocity += transform.basis.z
	if Input.is_action_pressed("camera_left"):
		velocity -= transform.basis.x
	if Input.is_action_pressed("camera_right"):
		velocity += transform.basis.x
	
	velocity.normalized()
	
	# translate
	translation += velocity * delta * movement_speed
