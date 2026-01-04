extends Node

## Global game settings singleton.
## Manages UI preferences and visibility options.

# Health bar settings
var health_bar_mode: String = "injured"  # Options: never, always, injured

# Name display settings
var show_friendly_names: bool = true
var show_neutral_names: bool = true
var show_hostile_names: bool = true
var show_boss_names: bool = true
var show_level: bool = true

# Health/Mana display (for player and other players)
var show_own_health: bool = true
var show_own_mana: bool = false
var show_other_health: bool = false
var show_other_mana: bool = false

# Health bar format
var health_bar_format: String = "bar"  # Options: bar, numbers, percent

# Signal emitted when any setting changes
signal settings_changed()

func apply_settings():
	"""Apply current settings to all units and UI elements."""
	settings_changed.emit()
