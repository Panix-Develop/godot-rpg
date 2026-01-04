extends Node3D

## Manages unit selection and command input for RTS gameplay.
## Handles single selection, box selection, shift-selection, and move commands.

var selected_units: Array = []
var is_box_selecting: bool = false
var box_select_start: Vector2
var box_select_end: Vector2
var player_unit: Node = null  # Reference to the player's unit

@onready var camera = $Camera3D
@onready var units_container = $Units
@onready var hud = $HUD

# Performance testing configuration
@export var test_unit_count: int = 3  # Change to 20 or 50 for performance testing

func _ready():
	# Spawn units in grid pattern for testing
	spawn_units_in_grid(test_unit_count)
	# Cache player unit reference (first unit spawned)
	if units_container.get_child_count() > 0:
		player_unit = units_container.get_child(0)
	update_hud()

func spawn_units_in_grid(count: int):
	"""Spawns units in a grid pattern for performance testing."""
	var spacing = 2.5
	var units_per_row = int(ceil(sqrt(count)))
	
	for i in range(count):
		var row = floor(i / units_per_row)
		var col = i % units_per_row
		var pos = Vector3(
			(col - units_per_row / 2.0) * spacing,
			0.5,  # Spawn at 0.5 to prevent terrain clipping
			(row - units_per_row / 2.0) * spacing
		)
		spawn_unit(pos)

func _input(event):
	# Left click for selection and movement
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			box_select_start = event.position
			is_box_selecting = true
		else:
			if is_box_selecting:
				box_select_end = event.position
				# Check if it's a single click (very small movement)
				if box_select_start.distance_to(box_select_end) < 5:
					perform_single_selection(box_select_start)
				else:
					perform_box_selection()
				is_box_selecting = false
				hud.update_selection_box(false)
				update_hud()
	
	# Right click for move command
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if selected_units.size() > 0:
			var target_pos = get_world_position_from_mouse(event.position)
			if target_pos:
				# Apply formation spread for multiple units
				if selected_units.size() == 1:
					selected_units[0].set_target_position(target_pos)
				else:
					# Spread units in a grid formation
					var spacing = 1.5  # Distance between units
					var units_per_row = int(ceil(sqrt(selected_units.size())))
					var index = 0
					
					for unit in selected_units:
						var row = floor(index / units_per_row)
						var col = index % units_per_row
						var offset = Vector3(
							(col - units_per_row / 2.0) * spacing,
							0,
							row * spacing
						)
						unit.set_target_position(target_pos + offset)
						index += 1

func _process(_delta):
	if is_box_selecting:
		box_select_end = get_viewport().get_mouse_position()
		update_selection_box()

func update_selection_box():
	var rect = get_selection_rect()
	hud.update_selection_box(true, rect)

func get_selection_rect() -> Rect2:
	var start = box_select_start
	var end = box_select_end
	var pos = Vector2(min(start.x, end.x), min(start.y, end.y))
	var size = Vector2(abs(end.x - start.x), abs(end.y - start.y))
	return Rect2(pos, size)

func perform_box_selection():
	# This handles the edge case where dragging is minimal
	var rect = get_selection_rect()
	
	# If it's just a click (very small box), do single selection
	if rect.size.length() < 5:
		perform_single_selection(box_select_start)
		return
	
	# Clear previous selection if not holding shift
	if not Input.is_key_pressed(KEY_SHIFT):
		clear_selection()
	
	# Select all units within the box
	for unit in units_container.get_children():
		var screen_pos = camera.unproject_position(unit.global_position)
		if rect.has_point(screen_pos):
			add_unit_to_selection(unit)

func perform_single_selection(mouse_pos: Vector2):
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	if result:
		var collider = result.collider
		# Check if we hit a unit
		if collider.get_parent() is CharacterBody3D:
			var unit = collider.get_parent()
			if not Input.is_key_pressed(KEY_SHIFT):
				clear_selection()
			add_unit_to_selection(unit)
		else:
			# Clicked on terrain, clear selection if not holding shift
			if not Input.is_key_pressed(KEY_SHIFT):
				clear_selection()

func get_world_position_from_mouse(mouse_pos: Vector2) -> Vector3:
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	
	if result:
		return result.position
	return Vector3.ZERO

func add_unit_to_selection(unit):
	if unit not in selected_units:
		selected_units.append(unit)
		unit.set_selected(true)
		update_hud()

func clear_selection():
	for unit in selected_units:
		if is_instance_valid(unit):
			unit.set_selected(false)
	selected_units.clear()
	update_hud()

func spawn_unit(pos: Vector3):
	var unit_scene = load("res://scenes/units/rts_unit.tscn")
	var unit = unit_scene.instantiate()
	units_container.add_child(unit)
	unit.global_position = pos

func update_hud():
	hud.update_unit_info(selected_units, player_unit)
