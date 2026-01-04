extends CanvasLayer

@onready var selection_box = $SelectionBox
@onready var bottom_panel = $BottomPanel
@onready var settings_panel = $SettingsPanel

# Unit info elements
@onready var unit_portrait = $BottomPanel/HBoxContainer/UnitPortrait
@onready var unit_name_label = $BottomPanel/HBoxContainer/UnitInfo/TopRow/UnitName
@onready var unit_level_label = $BottomPanel/HBoxContainer/UnitInfo/TopRow/UnitLevel
@onready var unit_health_bar = $BottomPanel/HBoxContainer/UnitInfo/HealthRow/UnitHealth
@onready var unit_health_label = $BottomPanel/HBoxContainer/UnitInfo/HealthRow/UnitHealthLabel
@onready var experience_label = $BottomPanel/HBoxContainer/UnitInfo/ExperienceLabel

# Stats elements
@onready var str_value = $BottomPanel/HBoxContainer/UnitInfo/StatsContainer/StrValue
@onready var con_value = $BottomPanel/HBoxContainer/UnitInfo/StatsContainer/ConValue
@onready var dex_value = $BottomPanel/HBoxContainer/UnitInfo/StatsContainer/DexValue
@onready var agi_value = $BottomPanel/HBoxContainer/UnitInfo/StatsContainer/AgiValue
@onready var int_value = $BottomPanel/HBoxContainer/UnitInfo/StatsContainer/IntValue
@onready var wis_value = $BottomPanel/HBoxContainer/UnitInfo/StatsContainer/WisValue

# Combat stats
@onready var attack_label = $BottomPanel/HBoxContainer/UnitInfo/CombatStats/AttackLabel
@onready var armor_label = $BottomPanel/HBoxContainer/UnitInfo/CombatStats/ArmorLabel
@onready var unspent_points_label = $BottomPanel/HBoxContainer/UnitInfo/CombatStats/UnspentPointsLabel

var camera_controller: Camera3D = null

func _ready() -> void:
	# Get camera reference for disabling during UI interactions
	var root = get_tree().root
	camera_controller = root.get_node_or_null("Main/Camera3D")
	
	# Connect to settings panel visibility changes
	if settings_panel:
		settings_panel.visibility_changed.connect(_on_settings_panel_visibility_changed)

func _on_settings_panel_visibility_changed() -> void:
	"""Disable camera when settings panel is open."""
	if camera_controller and camera_controller.has_method("set_camera_enabled"):
		camera_controller.set_camera_enabled(!settings_panel.visible)

func _on_menu_button_pressed():
	settings_panel.visible = !settings_panel.visible

func update_selection_box(box_visible: bool, rect: Rect2 = Rect2()):
	selection_box.visible = box_visible
	if box_visible:
		selection_box.position = rect.position
		selection_box.size = rect.size

func update_unit_info(selected_units: Array, player_unit: Node = null):
	if selected_units.size() == 1 and is_instance_valid(selected_units[0]):
		display_single_unit(selected_units[0])
	elif selected_units.size() > 1:
		display_multiple_units(selected_units)
	else:
		# Show player unit info when nothing is selected
		if is_instance_valid(player_unit):
			display_single_unit(player_unit, true)
		else:
			bottom_panel.visible = false

func display_single_unit(unit: Node, is_default_display: bool = false):
	"""Display detailed info for a single unit."""
	var info = unit.get_unit_info()
	
	# Set name and level
	var display_text = info["name"]
	if is_default_display:
		display_text += " (Player)"
	unit_name_label.text = display_text
	unit_level_label.text = "Level %d" % info["level"]
	
	# Set health bar
	var health_percent = (info["health"] / info["max_health"]) * 100 if info["max_health"] > 0 else 0
	unit_health_bar.value = health_percent
	
	# Format health label based on settings
	match GameSettings.health_bar_format:
		"numbers":
			unit_health_label.text = "Health: %d/%d" % [info["health"], info["max_health"]]
		"percent":
			unit_health_label.text = "Health: %d%%" % health_percent
		_:  # "bar"
			unit_health_label.text = ""
	
	# Experience (only for player units)
	if "experience" in info and info.get("experience_to_next", 0) > 0:
		experience_label.text = "XP: %d / %d" % [info["experience"], info["experience_to_next"]]
		experience_label.visible = true
	else:
		experience_label.visible = false
	
	# Stats
	var stats = info.get("stats", {})
	str_value.text = str(stats.get("strength", 0))
	con_value.text = str(stats.get("constitution", 0))
	dex_value.text = str(stats.get("dexterity", 0))
	agi_value.text = str(stats.get("agility", 0))
	int_value.text = str(stats.get("intelligence", 0))
	wis_value.text = str(stats.get("wisdom", 0))
	
	# Combat stats
	attack_label.text = "Attack: %d" % info.get("attack_damage", 0)
	armor_label.text = "Armor: %d" % info.get("armor", 0)
	
	# Unspent points
	var unspent = info.get("unspent_points", 0)
	if unspent > 0:
		unspent_points_label.text = "Unspent Points: %d" % unspent
		unspent_points_label.visible = true
	else:
		unspent_points_label.visible = false
	
	# Set portrait color based on unit type (simple for now)
	if unit.has_method("is_in_group"):
		if unit.is_in_group("unit_player"):
			unit_portrait.color = Color(0.29, 0.56, 0.89)  # Blue
		elif unit.is_in_group("unit_enemy"):
			unit_portrait.color = Color(0.91, 0.30, 0.24)  # Red
		elif unit.is_in_group("unit_neutral"):
			unit_portrait.color = Color(1.0, 0.84, 0.0)    # Yellow
		else:
			unit_portrait.color = Color(0.31, 0.78, 0.47)  # Green (friendly)
	
	unit_health_bar.visible = true
	unit_portrait.visible = true
	bottom_panel.visible = true

func display_multiple_units(units: Array):
	"""Display info for multiple selected units."""
	unit_name_label.text = "Multiple Units (%d)" % units.size()
	unit_level_label.text = ""
	unit_health_label.text = ""
	experience_label.visible = false
	unit_health_bar.visible = false
	unit_portrait.visible = false
	unspent_points_label.visible = false
	
	# Clear stats display
	str_value.text = "-"
	con_value.text = "-"
	dex_value.text = "-"
	agi_value.text = "-"
	int_value.text = "-"
	wis_value.text = "-"
	attack_label.text = "Attack: -"
	armor_label.text = "Armor: -"
	
	bottom_panel.visible = true
