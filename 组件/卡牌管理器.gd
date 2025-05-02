extends Node2D

var rotation_allowed = true
var card_being_dragged  # 检测卡牌是否被移动
var spins_number = 0
var player_hand_reference
func _ready() -> void:
	player_hand_reference = $"../手牌"
	#var rng = RandomNumberGenerator.new()
	#for i in BasicAttributes.cards :
		#rng.randomize()
		#var random = rng.randi() % 2
		#var card = preload("res://卡牌/基础卡牌.tscn")
		#var Card = card.instantiate()
		#Card.position = Vector2(200,200)
		#Card.assignment(i[random])
		#add_child(Card)
	pass

func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = mouse_pos

func start_drag(card):
	card_being_dragged = card

func finish_drag():
	var card_slot_found = raycast_check_for_card_slot()
	if card_slot_found:
		card_being_dragged.global_position = card_slot_found.global_position
		card_being_dragged.get_node("Area2D/CollisionShape2D").disabled = true
		card_being_dragged.change()
		$"../手牌".head_card.erase(card_being_dragged)
		$"../牌堆".add_card()
	else :
		player_hand_reference.add_card_to_hand(card_being_dragged)
	card_being_dragged = null
func _input(event: InputEvent) -> void:
	var card = raycast_check_for_card()
	var tween = create_tween().set_parallel(true)

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			#var card = raycast_check_for_card()
			if card and card_being_dragged == null:
				if card.spins_number % 2 == 0:
					$"../GridContainer".position = Vector2(0,0) 
				start_drag(card)
			elif card and card_being_dragged != null:
				if card.spins_number % 2 == 0:
					$"../GridContainer".position = Vector2(0,0) 
				finish_drag()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			if card and rotation_allowed:
				rotation_allowed = false
				card.spins_number += 1
				tween.tween_property(card , "rotation" , card.rotation + PI/2 , 0.2)
				await tween.finished
				if card.spins_number % 2 == 0:
					$"../GridContainer".position = Vector2(0,0) 
				else :
					$"../GridContainer".position.y += 48
					$"../GridContainer".position.x += 48
				rotation_allowed = true

func connect_card_parents(card):
	card.connect("hovered",on_hovered_over_card)
	card.connect("hovered_off",on_hovered_off_card)

func on_hovered_over_card(card):
	print(1)

func on_hovered_off_card(card):
	print(2)

func raycast_check_for_card_slot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 2
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		return result[0].collider.get_parent()
	return null

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		return result[0].collider.get_parent()
	return null


func _on_基础卡牌_hovered() -> void:
	pass # Replace with function body.
