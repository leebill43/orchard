extends Node2D
var spins_number = 0

signal hovered
signal hovered_off
var head_card_position 
var color_position = ["Marker2D","Marker2D2","Marker2D3","Marker2D4","Marker2D5","Marker2D6"]
var color_position_number = -1
var is_placed = false
func _ready() -> void:
	get_parent().connect_card_parents(self)


func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered",self)

func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off",self)

func assignment(colors):
	for i in colors:
		color_position_number += 1
		if i == "r":
			var red = preload("res://卡牌/色块/红.tscn")
			var Red = red.instantiate()
			Red.global_position = Vector2(0,0)
			#zdd.global_position = $Marker2D.global_position
			get_node(color_position[color_position_number]).add_child(Red)
			
		if i == "b":
			var blue = preload("res://卡牌/色块/蓝.tscn")
			var Blue = blue.instantiate()
			Blue.global_position = Vector2(0,0)
			#zdd.global_position = $Marker2D.global_position
			get_node(color_position[color_position_number]).add_child(Blue)
			
		if i == "y":
			var yellow = preload("res://卡牌/色块/黄.tscn")
			var Yellow = yellow.instantiate()
			Yellow.global_position = Vector2(0,0)
			#zdd.global_position = $Marker2D.global_position
			get_node(color_position[color_position_number]).add_child(Yellow)



func change():
	for i in color_position:
		get_node(i).get_child(0).is_put()
