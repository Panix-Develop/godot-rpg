extends PanelContainer

## Debug menu for testing and modifying game state.
## Toggle with F12 key. Provides controls for:
## - Level manipulation
## - Experience addition
## - Unit spawning
## - Stat modification

@onready var level_up_button: Button = $MarginContainer/VBoxContainer/LevelSection/LevelUpButton
@onready var experience_input: LineEdit = $MarginContainer/VBoxContainer/ExperienceSection/HBoxContainer/ExperienceInput
@onready var add_xp_button: Button = $MarginContainer/VBoxContainer/ExperienceSection/HBoxContainer/AddXPButton
@onready var spawn_neutral_button: Button = $MarginContainer/VBoxContainer/SpawnSection/SpawnNeutralButton
@onready var spawn_enemy_button: Button = $MarginContainer/VBoxContainer/SpawnSection/SpawnEnemyButton
@onready var stat_selector: OptionButton = $MarginContainer/VBoxContainer/StatSection/StatSelector
@onready var stat_input: LineEdit = $MarginContainer/VBoxContainer/StatSection/HBoxContainer/StatInput
@onready var add_stat_button: Button = $MarginContainer/VBoxContainer/StatSection/HBoxContainer/AddStatButton
@onready var status_label: Label = $MarginContainer/VBoxContainer/InfoSection/StatusLabel

var selection_manager: Node = null


func _ready() -> void:
	# Populate stat selector
	stat_selector.add_item("Strength", 0)
	stat_selector.add_item("Constitution", 1)
	stat_selector.add_item("Dexterity", 2)
	stat_selector.add_item("Agility", 3)
	stat_selector.add_item("Intelligence", 4)
	stat_selector.add_item("Wisdom", 5)
	
	# Get selection manager reference
	var root = get_tree().root
	selection_manager = root.get_node_or_null("Main/SelectionManager")
	
	if not selection_manager:
		push_warning("DebugPanel: Could not find SelectionManager")
	
	# Update status
	_update_status()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F12:
			visible = !visible
			get_viewport().set_input_as_handled()


func _on_level_up_button_pressed() -> void:
	"""Add 1 level to the selected unit."""
	var selected_units = _get_selected_units()
	if selected_units.is_empty():
		_set_status("No unit selected", true)
		return
	
	var unit = selected_units[0]
	if unit.has_method("level_up_unit"):
		unit.level_up_unit()
		_set_status("Level up! Unit is now level %d" % unit.level, false)
	else:
		_set_status("Unit does not support leveling", true)


func _on_add_xp_button_pressed() -> void:
	"""Add experience to the player unit."""
	if not selection_manager or not selection_manager.player_unit:
		_set_status("No player unit found", true)
		return
	
	var xp_text = experience_input.text
	if xp_text.is_empty():
		_set_status("Enter XP amount", true)
		return
	
	var xp_amount = int(xp_text)
	if xp_amount <= 0:
		_set_status("XP must be positive", true)
		return
	
	var player = selection_manager.player_unit
	if player.has_method("add_experience"):
		player.add_experience(xp_amount)
		_set_status("Added %d XP to player" % xp_amount, false)
		experience_input.text = ""
	else:
		_set_status("Player does not support experience", true)


func _on_spawn_neutral_button_pressed() -> void:
	"""Spawn a neutral unit at a random location."""
	_spawn_unit("res://scenes/units/neutral_unit.tscn", "Neutral")


func _on_spawn_enemy_button_pressed() -> void:
	"""Spawn an enemy unit at a random location."""
	_spawn_unit("res://scenes/units/enemy_unit.tscn", "Enemy")


func _spawn_unit(scene_path: String, unit_type: String) -> void:
	"""Helper to spawn a unit at random position."""
	if not selection_manager:
		_set_status("SelectionManager not found", true)
		return
	
	# Generate random position near origin
	var random_offset = Vector3(
		randf_range(-10, 10),
		1.0,
		randf_range(-10, 10)
	)
	
	if selection_manager.has_method("spawn_unit_type"):
		selection_manager.spawn_unit_type(random_offset, scene_path)
		_set_status("%s unit spawned" % unit_type, false)
	else:
		_set_status("Cannot spawn unit", true)


func _on_add_stat_button_pressed() -> void:
	"""Add stat points to selected unit."""
	var selected_units = _get_selected_units()
	if selected_units.is_empty():
		_set_status("No unit selected", true)
		return
	
	var stat_text = stat_input.text
	if stat_text.is_empty():
		_set_status("Enter stat amount", true)
		return
	
	var stat_amount = int(stat_text)
	if stat_amount <= 0:
		_set_status("Stat amount must be positive", true)
		return
	
	# Get selected stat name
	var stat_names = ["strength", "constitution", "dexterity", "agility", "intelligence", "wisdom"]
	var selected_index = stat_selector.selected
	var stat_name = stat_names[selected_index]
	
	var unit = selected_units[0]
	if unit.has_method("add_stat"):
		unit.add_stat(stat_name, stat_amount)
		_set_status("Added %d to %s" % [stat_amount, stat_name.capitalize()], false)
		stat_input.text = ""
	else:
		_set_status("Unit does not support stat modification", true)


func _get_selected_units() -> Array:
	"""Get currently selected units from SelectionManager."""
	if not selection_manager:
		return []
	
	if selection_manager.has("selected_units"):
		return selection_manager.selected_units
	
	return []


func _set_status(message: String, is_error: bool) -> void:
	"""Update status label with message."""
	status_label.text = message
	
	if is_error:
		status_label.add_theme_color_override("font_color", Color(1, 0.4, 0.4, 1))
	else:
		status_label.add_theme_color_override("font_color", Color(0.4, 1, 0.4, 1))
	
	# Reset to default color after 3 seconds
	await get_tree().create_timer(3.0).timeout
	if is_instance_valid(status_label):
		_update_status()


func _update_status() -> void:
	"""Update status to show selected unit info."""
	var selected_units = _get_selected_units()
	
	if selected_units.is_empty():
		status_label.text = "No unit selected"
		status_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7, 1))
	else:
		var unit = selected_units[0]
		var info = unit.get_unit_info() if unit.has_method("get_unit_info") else {}
		var unit_name = info.get("name", "Unknown")
		var level = info.get("level", 1)
		status_label.text = "Selected: %s (Lvl %d)" % [unit_name, level]
		status_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7, 1))


func _process(_delta: float) -> void:
	"""Continuously update status when visible."""
	if visible:
		_update_status()
