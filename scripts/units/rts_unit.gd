extends CharacterBody3D

## Base unit class for RTS units.
## Handles movement, selection, health, and basic combat readiness.
##
## Note: Units use CharacterBody3D collision and can block each other.
## Pathfinding/navigation is not implemented - units may get stuck behind obstacles.
## This is acceptable for current phase; pathfinding will be added in future iterations.

@export var unit_name: String = "Warrior"
@export var unit_type: String = "Friendly"  # Options: Player, Friendly, Neutral, Enemy
@export var display_name: String = "Unit"
@export var max_health: float = 100.0
@export var move_speed: float = 5.0
@export var rotation_speed: float = 10.0  # Degrees per frame for smooth rotation

# Base stats for damage/armor calculations
@export var base_damage: int = 5
@export var base_armor: int = 0
@export var base_health: int = 100

# Core stats
var stats = {
	"strength": 10,
	"constitution": 10,
	"dexterity": 10,
	"agility": 10,
	"intelligence": 10,
	"wisdom": 10
}

# Leveling system
@export var level: int = 1
var experience: int = 0
var unspent_stat_points: int = 0

# Signals
signal level_up(new_level: int)
signal stat_changed(stat_name: String, new_value: int)

var current_health: float
var is_selected: bool = false
var target_position: Vector3
var is_moving: bool = false

@onready var selection_indicator = $SelectionIndicator
@onready var mesh_instance = $MeshInstance3D
@onready var floating_ui = $FloatingUI

func _ready():
	# Scale NPC stats if not player-controlled
	if not is_player_controlled():
		scale_npc_stats()
	
	current_health = get_max_health()
	max_health = get_max_health()  # Update export var for display
	add_to_group("unit")  # Add to unit group for selection detection
	# Add to type-specific group for classification
	add_to_group("unit_" + unit_type.to_lower())
	apply_unit_color()
	update_selection_visual()
	
	# Initialize floating UI
	if floating_ui:
		floating_ui.update_name(display_name if display_name else unit_name)
		floating_ui.update_level(level)
		floating_ui.update_health(int(current_health), int(get_max_health()))

func apply_unit_color():
	"""Apply color material based on unit type."""
	var material: StandardMaterial3D
	match unit_type:
		"Player":
			material = load("res://assets/materials/mat_player.tres")
		"Friendly":
			material = load("res://assets/materials/mat_friendly.tres")
		"Neutral":
			material = load("res://assets/materials/mat_neutral.tres")
		"Enemy":
			material = load("res://assets/materials/mat_enemy.tres")
		_:
			material = load("res://assets/materials/mat_friendly.tres")  # Default
	
	if material and mesh_instance:
		mesh_instance.material_override = material

func _physics_process(delta):
	if is_moving:
		move_to_target(delta)

func move_to_target(delta):
	var direction = (target_position - global_position).normalized()
	direction.y = 0  # Keep movement on the ground plane
	
	var distance = global_position.distance_to(target_position)
	
	if distance > 0.5:
		velocity = direction * move_speed
		
		# Use move_and_slide which handles collisions automatically
		move_and_slide()
		
		# Smooth rotation toward movement direction
		if direction.length() > 0:
			var target_rotation = atan2(direction.x, direction.z)
			rotation.y = lerp_angle(rotation.y, target_rotation, rotation_speed * delta)
	else:
		# Reached destination
		is_moving = false
		velocity = Vector3.ZERO

func set_target_position(pos: Vector3):
	target_position = pos
	target_position.y = global_position.y  # Keep on same height
	is_moving = true
	is_moving = true

func set_selected(selected: bool):
	is_selected = selected
	update_selection_visual()

func update_selection_visual():
	if selection_indicator:
		selection_indicator.visible = is_selected
		if is_selected and not selection_indicator.material_override:
			# Only create material once, mesh is already configured in scene
			var mat = StandardMaterial3D.new()
			mat.albedo_color = Color(0, 1, 0, 0.5)
			mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			selection_indicator.material_override = mat

func take_damage(amount: float):
	current_health = max(0, current_health - amount)
	
	# Update floating UI
	if floating_ui:
		floating_ui.update_health(int(current_health), int(get_max_health()))
	
	if current_health <= 0:
		die()

func die():
	queue_free()

func get_unit_info() -> Dictionary:
	return {
		"name": display_name if display_name else unit_name,
		"health": current_health,
		"max_health": get_max_health(),
		"level": level,
		"experience": experience,
		"experience_to_next": get_experience_to_next_level(),
		"stats": stats.duplicate(),
		"attack_damage": get_attack_damage(),
		"armor": get_armor(),
		"unspent_points": unspent_stat_points
	}

# Derived stat calculations
func get_attack_damage() -> int:
	return base_damage + (stats.strength * 2)

func get_armor() -> int:
	return base_armor + stats.dexterity

func get_max_health() -> int:
	return base_health + (stats.constitution * 10)

func get_experience_to_next_level() -> int:
	return level * 100

# Leveling system
func is_player_controlled() -> bool:
	return is_in_group("unit_player")

func add_experience(amount: int):
	if not is_player_controlled():
		return  # Only player units gain experience
	
	experience += amount
	
	# Check for level up
	while experience >= get_experience_to_next_level():
		experience -= get_experience_to_next_level()
		level_up_unit()

func level_up_unit():
	level += 1
	unspent_stat_points += 5
	
	# Recalculate health based on new max
	var health_percent = current_health / max_health if max_health > 0 else 1.0
	max_health = get_max_health()
	current_health = max_health * health_percent
	
	# Update floating UI
	if floating_ui:
		floating_ui.update_level(level)
		floating_ui.update_health(int(current_health), int(max_health))
	
	level_up.emit(level)

func scale_npc_stats():
	"""Scale NPC stats based on level for non-player units."""
	if level > 1:
		for stat_name in stats.keys():
			stats[stat_name] = 10 + (level * 2)

func add_stat(stat_name: String, amount: int):
	"""Add points to a specific stat."""
	if stat_name in stats:
		stats[stat_name] += amount
		stats[stat_name] = clamp(stats[stat_name], 1, 999)
		
		# Update derived stats
		max_health = get_max_health()
		if current_health > max_health:
			current_health = max_health
		
		# Update floating UI if constitution changed
		if stat_name == "constitution" and floating_ui:
			floating_ui.update_health(int(current_health), int(max_health))
		
		stat_changed.emit(stat_name, stats[stat_name])
