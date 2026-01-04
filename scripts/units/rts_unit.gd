extends CharacterBody3D

@export var unit_name: String = "Warrior"
@export var max_health: float = 100.0
@export var move_speed: float = 5.0

var current_health: float
var is_selected: bool = false
var target_position: Vector3
var is_moving: bool = false

@onready var selection_indicator = $SelectionIndicator
@onready var mesh_instance = $MeshInstance3D

func _ready():
	current_health = max_health
	update_selection_visual()

func _physics_process(delta):
	if is_moving:
		move_to_target(delta)

func move_to_target(_delta):
	var direction = (target_position - global_position).normalized()
	direction.y = 0  # Keep movement on the ground plane
	
	var distance = global_position.distance_to(target_position)
	
	if distance > 0.5:
		velocity = direction * move_speed
		move_and_slide()
		
		# Rotate to face movement direction
		if direction.length() > 0:
			look_at(global_position + direction, Vector3.UP)
	else:
		is_moving = false
		velocity = Vector3.ZERO

func set_target_position(pos: Vector3):
	target_position = pos
	target_position.y = global_position.y  # Keep on same height
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
	if current_health <= 0:
		die()

func die():
	queue_free()

func get_unit_info() -> Dictionary:
	return {
		"name": unit_name,
		"health": current_health,
		"max_health": max_health
	}
