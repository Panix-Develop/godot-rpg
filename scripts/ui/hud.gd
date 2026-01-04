extends CanvasLayer

@onready var selection_box = $SelectionBox
@onready var bottom_panel = $BottomPanel
@onready var unit_portrait = $BottomPanel/HBoxContainer/UnitPortrait
@onready var unit_info = $BottomPanel/HBoxContainer/UnitInfo
@onready var unit_name_label = $BottomPanel/HBoxContainer/UnitInfo/UnitName
@onready var unit_health_bar = $BottomPanel/HBoxContainer/UnitInfo/UnitHealth
@onready var unit_health_label = $BottomPanel/HBoxContainer/UnitInfo/UnitHealthLabel

func update_selection_box(box_visible: bool, rect: Rect2 = Rect2()):
	selection_box.visible = box_visible
	if box_visible:
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
		unit_portrait.visible = true
		bottom_panel.visible = true
	elif selected_units.size() > 1:
		unit_name_label.text = "Multiple Units (%d)" % selected_units.size()
		unit_health_label.text = ""
		unit_health_bar.visible = false
		unit_portrait.visible = false
		bottom_panel.visible = true
	else:
		bottom_panel.visible = false
