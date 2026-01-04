extends Camera3D

## Controls camera movement, zoom, and bounds for RTS gameplay.
## Supports WASD, arrow keys, edge scrolling, and mouse wheel zoom.

@export var move_speed: float = 20.0
@export var edge_margin: int = 20
@export var zoom_speed: float = 2.0
@export var min_zoom: float = 10.0
@export var max_zoom: float = 30.0
@export var map_bounds: Vector2 = Vector2(25, 25)  # Half-size of terrain (50x50 / 2)

var camera_distance: float = 15.0

func _ready():
	# Set isometric angle (45 degrees horizontal, 35 degrees vertical)
	rotation_degrees = Vector3(-35, 45, 0)
	update_camera_position()

func _process(delta):
	handle_camera_movement(delta)
	handle_camera_zoom(delta)

func handle_camera_movement(delta):
	var viewport_size = get_viewport().get_visible_rect().size
	var mouse_pos = get_viewport().get_mouse_position()
	var move_direction = Vector3.ZERO
	
	# Edge scrolling
	if mouse_pos.x < edge_margin:
		move_direction.x -= 1
	elif mouse_pos.x > viewport_size.x - edge_margin:
		move_direction.x += 1
	
	if mouse_pos.y < edge_margin:
		move_direction.z -= 1
	elif mouse_pos.y > viewport_size.y - edge_margin:
		move_direction.z += 1
	
	# WASD movement
	if Input.is_action_pressed("ui_left"):
		move_direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		move_direction.x += 1
	if Input.is_action_pressed("ui_up"):
		move_direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		move_direction.z += 1
	
	if move_direction != Vector3.ZERO:
		move_direction = move_direction.normalized()
		# Transform movement relative to camera rotation
		var forward = -global_transform.basis.z
		var right = global_transform.basis.x
		forward.y = 0
		right.y = 0
		forward = forward.normalized()
		right = right.normalized()
		
		var movement = (right * move_direction.x + forward * -move_direction.z) * move_speed * delta
		global_position += movement
		
		# Clamp camera position to map bounds
		global_position.x = clamp(global_position.x, -map_bounds.x, map_bounds.x)
		global_position.z = clamp(global_position.z, -map_bounds.y, map_bounds.y)

func handle_camera_zoom(_delta):
	if Input.is_action_just_released("scroll_up"):
		camera_distance = clamp(camera_distance - zoom_speed, min_zoom, max_zoom)
		update_camera_position()
	elif Input.is_action_just_released("scroll_down"):
		camera_distance = clamp(camera_distance + zoom_speed, min_zoom, max_zoom)
		update_camera_position()

func update_camera_position():
	# Maintain isometric angle while zooming
	var angle_rad = deg_to_rad(-35)
	position.y = camera_distance * sin(-angle_rad)
	position.z = camera_distance * cos(-angle_rad)
