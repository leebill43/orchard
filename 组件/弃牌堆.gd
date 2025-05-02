extends Node2D

var plater_deck = [
	[["y","y","b","r","r","b"],["y","y","b","r","b","r"]],
	[["y","b","r","y","b","r"],["y","b","y","r","b","r"]],
	[["y","b","r","r","b","y"],["b","y","r","r","b","y"]],
	[["b","r","y","b","r","y"],["b","r","b","y","r","y"]],
	[["r","y","b","r","y","b"],["r","y","r","b","y","b"]],
	[["y","r","b","b","y","r"],["r","y","b","b","y","r"]],
	[["b","y","b","y","r","r"],["y","b","b","y","r","r"]],
	[["r","b","y","y","r","b"],["b","r","y","y","r","b"]],
	[["r","y","y","r","b","b"],["y","r","y","r","b","b"]],
]

func add_card():
	if plater_deck.size() == 0:
		$Sprite2D.visible = false
	else:
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var random_pan = rng.randi() % 2
		var random = rng.randi() % plater_deck.size()
		var card_count = plater_deck[random][random_pan]
		var card = preload("res://卡牌/基础卡牌.tscn")
		var Card = card.instantiate()
		Card.position = Vector2(200,200)
		Card.assignment(card_count)
		plater_deck.remove_at(random)
		$"../卡牌管理器".add_child(Card)
		$"../手牌".add_card_to_hand(Card)
