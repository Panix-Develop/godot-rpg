extends PanelContainer

## Settings panel for configuring UI preferences.
## All changes apply immediately to GameSettings singleton.

@onready var health_bar_mode = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/HealthBarSection/HealthBarMode
@onready var show_friendly_names = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/NameDisplaySection/ShowFriendlyNames
@onready var show_neutral_names = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/NameDisplaySection/ShowNeutralNames
@onready var show_hostile_names = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/NameDisplaySection/ShowHostileNames
@onready var show_boss_names = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/NameDisplaySection/ShowBossNames
@onready var show_level = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/NameDisplaySection/ShowLevel
@onready var show_own_health = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/NameDisplaySection/ShowOwnHealth
@onready var show_own_mana = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/NameDisplaySection/ShowOwnMana
@onready var show_other_health = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/NameDisplaySection/ShowOtherHealth
@onready var show_other_mana = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/NameDisplaySection/ShowOtherMana
@onready var health_bar_format = $MarginContainer/VBoxContainer/ScrollContainer/SettingsContent/HealthBarFormatSection/HealthBarFormat

func _ready():
	# Populate dropdowns
	health_bar_mode.add_item("Never Show", 0)
	health_bar_mode.add_item("Always Show", 1)
	health_bar_mode.add_item("Show When Injured Only", 2)
	
	health_bar_format.add_item("Show Bar Only", 0)
	health_bar_format.add_item("Show Numbers", 1)
	health_bar_format.add_item("Show Percent", 2)
	
	# Load current settings
	load_settings()
	
	# Connect signals
	health_bar_mode.item_selected.connect(_on_health_bar_mode_changed)
	health_bar_format.item_selected.connect(_on_health_bar_format_changed)
	
	show_friendly_names.toggled.connect(func(pressed): GameSettings.show_friendly_names = pressed; GameSettings.apply_settings())
	show_neutral_names.toggled.connect(func(pressed): GameSettings.show_neutral_names = pressed; GameSettings.apply_settings())
	show_hostile_names.toggled.connect(func(pressed): GameSettings.show_hostile_names = pressed; GameSettings.apply_settings())
	show_boss_names.toggled.connect(func(pressed): GameSettings.show_boss_names = pressed; GameSettings.apply_settings())
	show_level.toggled.connect(func(pressed): GameSettings.show_level = pressed; GameSettings.apply_settings())
	show_own_health.toggled.connect(func(pressed): GameSettings.show_own_health = pressed; GameSettings.apply_settings())
	show_own_mana.toggled.connect(func(pressed): GameSettings.show_own_mana = pressed; GameSettings.apply_settings())
	show_other_health.toggled.connect(func(pressed): GameSettings.show_other_health = pressed; GameSettings.apply_settings())
	show_other_mana.toggled.connect(func(pressed): GameSettings.show_other_mana = pressed; GameSettings.apply_settings())

func load_settings():
	"""Load current settings from GameSettings singleton."""
	# Health bar mode
	match GameSettings.health_bar_mode:
		"never": health_bar_mode.selected = 0
		"always": health_bar_mode.selected = 1
		"injured": health_bar_mode.selected = 2
	
	# Health bar format
	match GameSettings.health_bar_format:
		"bar": health_bar_format.selected = 0
		"numbers": health_bar_format.selected = 1
		"percent": health_bar_format.selected = 2
	
	# Checkboxes
	show_friendly_names.button_pressed = GameSettings.show_friendly_names
	show_neutral_names.button_pressed = GameSettings.show_neutral_names
	show_hostile_names.button_pressed = GameSettings.show_hostile_names
	show_boss_names.button_pressed = GameSettings.show_boss_names
	show_level.button_pressed = GameSettings.show_level
	show_own_health.button_pressed = GameSettings.show_own_health
	show_own_mana.button_pressed = GameSettings.show_own_mana
	show_other_health.button_pressed = GameSettings.show_other_health
	show_other_mana.button_pressed = GameSettings.show_other_mana

func _on_health_bar_mode_changed(index: int):
	match index:
		0: GameSettings.health_bar_mode = "never"
		1: GameSettings.health_bar_mode = "always"
		2: GameSettings.health_bar_mode = "injured"
	GameSettings.apply_settings()

func _on_health_bar_format_changed(index: int):
	match index:
		0: GameSettings.health_bar_format = "bar"
		1: GameSettings.health_bar_format = "numbers"
		2: GameSettings.health_bar_format = "percent"
	GameSettings.apply_settings()

func _on_close_button_pressed():
	hide()
