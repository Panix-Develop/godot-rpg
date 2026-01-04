extends Node3D

## Manages unit selection and command input for RTS gameplay.
## Handles single selection, box selection, shift-selection, and move commands.

var selected_units: Array = []
var is_box_selecting: bool = false
var box_select_start: Vector2
var box_select_end: Vector2

@onready var camera = $Camera3D
@onready var units_container = $Units
@onready var hud = $HUD

func _ready():
	# Spawn some example units
	spawn_unit(Vector3(5, 0, 5))
	spawn_unit(Vector3(-5, 0, 5))
	spawn_unit(Vector3(0, 0, -5))
	update_hud()

func _input(event):
	# Left click for selection and movement
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			box_select_start = event.position
			is_box_selecting = true
		else:
			if is_box_selecting:
				box_select_end = event.position
				perform_box_selection()
				is_box_selecting = false
				hud.update_selection_box(false)
				update_hud()
	
	# Right click for move command
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if selected_units.size() > 0:
			var target_pos = get_world_position_from_mouse(event.position)
			if target_pos:
				for unit in selected_units:
					unit.set_target_position(target_pos)

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
	unit.global_position = pos
	units_container.add_child(unit)

func update_hud():
	hud.update_unit_info(selected_units)
