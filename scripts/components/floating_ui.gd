class_name FloatingUI
extends Node3D

## Floating UI component for units: health bar, name, and level display.
## Updates based on GameSettings preferences for visibility and format.

signal ui_updated

@export var offset_y: float = 2.5  ## Y offset above the unit
@export var always_visible: bool = false  ## Override settings for boss units

@onready var name_label: Label3D = $NameLabel
@onready var level_label: Label3D = $LevelLabel
@onready var health_bar_sprite: Sprite3D = $HealthBarSprite
@onready var health_viewport: SubViewport = $HealthBarSprite/SubViewport
@onready var health_progress: ProgressBar = $HealthBarSprite/SubViewport/HealthProgress
@onready var health_text_label: Label = $HealthBarSprite/SubViewport/HealthText

var parent_unit: Node = null


func _ready() -> void:
	# Billboard mode for labels
	name_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	level_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	
	# Position at offset
	position.y = offset_y
	
	# Connect to GameSettings
	if GameSettings:
		GameSettings.settings_changed.connect(_on_settings_changed)
	
	# Get parent unit reference
	if get_parent() is CharacterBody3D:
		parent_unit = get_parent()
		_update_ui()


func _on_settings_changed() -> void:
	"""React to settings changes."""
	_update_ui()


func update_health(current: int, maximum: int) -> void:
	"""Update health bar display."""
	if not health_progress:
		return
	
	health_progress.max_value = maximum
	health_progress.value = current
	
	# Update text based on format
	match GameSettings.health_bar_format:
		"numbers":
			health_text_label.text = "%d/%d" % [current, maximum]
			health_text_label.visible = true
		"percent":
			var percent = (float(current) / maximum) * 100.0
			health_text_label.text = "%d%%" % percent
			health_text_label.visible = true
		_:  # "bar"
			health_text_label.visible = false
	
	_update_health_visibility(current, maximum)


func update_name(unit_name: String) -> void:
	"""Update name label."""
	name_label.text = unit_name
	_update_name_visibility()


func update_level(level: int) -> void:
	"""Update level label."""
	level_label.text = "Lvl %d" % level
	_update_level_visibility()


func _update_ui() -> void:
	"""Refresh all UI elements based on current state."""
	if not parent_unit:
		return
	
	var info = parent_unit.get_unit_info()
	update_health(info.get("health", 0), info.get("max_health", 1))
	update_name(info.get("name", "Unknown"))
	update_level(info.get("level", 1))


func _update_health_visibility(current: int, maximum: int) -> void:
	"""Control health bar visibility based on settings."""
	if not health_bar_sprite:
		return
	
	var should_show = false
	
	match GameSettings.health_bar_mode:
		"always":
			should_show = true
		"injured":
			should_show = current < maximum
		_:  # "never"
			should_show = false
	
	# Check unit-specific settings
	if parent_unit:
		if parent_unit.is_in_group("unit_player"):
			should_show = should_show and GameSettings.show_own_health
		else:
			should_show = should_show and GameSettings.show_other_health
	
	# Override for always_visible (boss units)
	if always_visible:
		should_show = true
	
	health_bar_sprite.visible = should_show


func _update_name_visibility() -> void:
	"""Control name label visibility based on settings."""
	if not name_label or not parent_unit:
		return
	
	var should_show = false
	
	if parent_unit.is_in_group("unit_player"):
		should_show = true  # Always show player name
	elif parent_unit.is_in_group("unit_friendly"):
		should_show = GameSettings.show_friendly_names
	elif parent_unit.is_in_group("unit_neutral"):
		should_show = GameSettings.show_neutral_names
	elif parent_unit.is_in_group("unit_enemy"):
		should_show = GameSettings.show_hostile_names
	
	name_label.visible = should_show


func _update_level_visibility() -> void:
	"""Control level label visibility based on settings."""
	if not level_label:
		return
	
	level_label.visible = GameSettings.show_level
