extends Spatial

# EXPORT PARAMS
export (float, 0, 1000) var movement_speed
# rotation
export (int, 0, 90) var min_elevation_angle = 10
export (int, 0, 90) var max_elevation_angle = 90
export (float, 0, 1000, 0.1) var rotation_speed = 20
# flags
export (bool) var allow_rotation = true


# params
var _last_mouse_position = Vector2()
var _is_rotating = false

# OVERWRITE FUNCTIONS
func _process(delta: float) -> void:
	_move(delta)
	_rotate(delta)

func _unhandled_input(event: InputEvent) -> void:
	# test if we are rotating
	if event.is_action_pressed("camera_rotate"):
		_is_rotating = true
		_last_mouse_position = get_viewport().get_mouse_position()
	if event.is_action_released("camera_rotate"):
		_is_rotating = false
	
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


func _rotate(delta: float) -> void:
	if not _is_rotating or not allow_rotation:
		return

	# calculate mouse movement
	var displacment = _get_mouse_desplacment()
	# use horisontal desplacment to rotate
	_rotate_left_right(delta, displacment.x)
	# use vertical desplacment to evelate


# HELPERS
func _get_mouse_desplacment() -> Vector2:
	var current_mouse_position = get_viewport().get_mouse_position()
	var displacment = current_mouse_position - _last_mouse_position
	_last_mouse_position = current_mouse_position
	return displacment

func _rotate_left_right(delta: float, val: float) -> void:
	rotation_degrees.y += val * delta * rotation_speed
