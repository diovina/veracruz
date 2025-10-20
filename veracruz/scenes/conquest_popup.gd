class_name ConquestPopup
extends PanelContainer

signal confirmed(zone_id: String)
signal cancelled

var zone_id: String = ""
var zone_name: String = ""
var cost: Dictionary = {}

@onready var title_label = $MarginContainer/VBoxContainer/TitleLabel
@onready var description_label = $MarginContainer/VBoxContainer/DescriptionLabel
@onready var cost_label = $MarginContainer/VBoxContainer/CostLabel
@onready var confirm_button = $MarginContainer/VBoxContainer/ButtonsContainer/ConfirmButton
@onready var cancel_button = $MarginContainer/VBoxContainer/ButtonsContainer/CancelButton

func _ready() -> void:
	
	confirm_button.pressed.connect(_on_confirm_pressed)
	cancel_button.pressed.connect(_on_cancel_pressed)

func setup(p_zone_id: String, p_zone_name: String, p_cost: Dictionary) -> void:
	zone_id = p_zone_id
	zone_name = p_zone_name
	cost = p_cost
	
	if title_label:
		title_label.text = "Conquistar %s" % zone_name
	
	if cost_label:
		var cost_text = "Costo: "
		for resource in cost:
			cost_text += "%d %s " % [cost[resource], resource]
		cost_label.text = cost_text
	
	# Verificar si puede pagar
	if ResourceManager.ref and confirm_button:
		confirm_button.disabled = not ResourceManager.ref.has_resources(cost)

func _on_confirm_pressed() -> void:
	print("Confirm button pressed!")  # ← Añade esto
	print("Emitting confirmed signal for:", zone_id)  # ← Y esto
	emit_signal("confirmed", zone_id)
	queue_free()

func _on_cancel_pressed() -> void:
	emit_signal("cancelled")
	queue_free()
