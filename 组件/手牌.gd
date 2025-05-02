extends Node2D

var head_card = []
var center_screen_x
var card_width = 200
var hand_y_position = 500

func _ready() -> void:
	center_screen_x = $"../Camera2D".get_screen_center_position().x
	hand_y_position = $"../Camera2D".get_screen_center_position().y + 288 * (1/$"../Camera2D".zoom.y) +50
	$"../牌堆".add_card()
	$"../牌堆".add_card()
	
	#var rng = RandomNumberGenerator.new()
	#for i in BasicAttributes.cards :
		#rng.randomize()
		#var random = rng.randi() % 2
		#var card = preload("res://卡牌/基础卡牌.tscn")
		#var Card = card.instantiate()
		#Card.position = Vector2(200,200)
		#Card.assignment(i[random])
		#$"../卡牌管理器".add_child(Card)
		#add_card_to_hand(Card)

#func _process(delta: float) -> void:
	#center_screen_x = $"../Camera2D".get_screen_center_position().x
	#hand_y_position = $"../Camera2D".get_screen_center_position().y + 288 * (1/$"../Camera2D".zoom.y) -50
	#print(100 * (1/$"../Camera2D".zoom.y))
	#print($"../Camera2D")
	
	#for i in head_card:
		#update_hand_position()

func return_pos():
	center_screen_x = $"../Camera2D".get_screen_center_position().x
	hand_y_position = $"../Camera2D".get_screen_center_position().y + 288 * (1/$"../Camera2D".zoom.y) -50
	for i in head_card:
		update_hand_position()

func add_card_to_hand(card):
	if card not in head_card:
		head_card.insert(0,card)
		update_hand_position()
	else:
		animate_card_to_position(card , card.head_card_position)

func update_hand_position():
	for i in range(head_card.size()):
		var new_position = Vector2(calculate_card_position(i) , hand_y_position)
		var card = head_card[i]
		card.head_card_position = new_position
		animate_card_to_position(card , new_position)
		pass

func calculate_card_position(index):
	var total_width = (head_card.size() - 1) * card_width
	var x_offset = center_screen_x + index * card_width - total_width / 2
	return x_offset

func animate_card_to_position(card , new_position):
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(card , "position" , new_position , 0.1)
	tween.parallel().tween_property(card , "rotation" , 0 , 0.1)
	pass
