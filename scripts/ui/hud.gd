extends CanvasLayer

@onready var selection_box = $SelectionBox
@onready var unit_info = $UnitInfo
@onready var unit_name_label = $UnitInfo/UnitName
@onready var unit_health_bar = $UnitInfo/UnitHealth
@onready var unit_health_label = $UnitInfo/UnitHealthLabel

func update_selection_box(is_visible: bool, rect: Rect2 = Rect2()):
	selection_box.visible = is_visible
	if is_visible:
		selection_box.position = rect.position
		selection_box.size = rect.size

func update_unit_info(selected_units: Array):
	if selected_units.size() == 1 and is_instance_valid(selected_units[0]):
		var unit = selected_units[0]
		var info = unit.get_unit_info()
		unit_name_label.text = info["name"]
		unit_health_bar.value = (info["health"] / info["max_health"]) * 100
		unit_health_label.text = "Health: %d/%d" % [info["health"], info["max_health"]]
		unit_health_bar.visible = true
		unit_info.visible = true
	elif selected_units.size() > 1:
		unit_name_label.text = "Multiple Units (%d)" % selected_units.size()
		unit_health_label.text = ""
		unit_health_bar.visible = false
		unit_info.visible = true
	else:
		unit_info.visible = false
