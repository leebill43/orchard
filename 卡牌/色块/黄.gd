extends Node2D
var points = [0,1,3,6]
var color = "yellow"
var full = false
@onready var red: Sprite2D = $Red

func is_put():
	if not full:
		$Area2D.collision_mask = 0
	#$Area2D.collision_layer = 0
		if points[$Color.frame] >= 1:
			BasicAttributes.point += points[$Color.frame] - points[$Color.frame - 1]



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().color == "yellow":
		
		if $Color.frame >= 3:
			$Area2D.collision_mask = 0
			BasicAttributes.point -= 3
			full = true
		else :
			$Color.frame += 1
			BasicAttributes.point += (points[$Color.frame ]  - points[$Color.frame - 1])/ $Color.frame 


	else :
		$False.visible = true
	#var tween = get_tree().create_tween()
	#tween.parallel().tween_property(red , "modulate" ,  Color(1, 1, 1, 0.5) , 0.4)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent().color == "yellow":
		if $Color.frame > 0 and not full:
			BasicAttributes.point -= (points[$Color.frame ]  - points[$Color.frame - 1])/ $Color.frame 
			$Color.frame -= 1
			
	else :
		$False.visible = false
	#var tween = get_tree().create_tween()
	#tween.parallel().tween_property(red , "modulate" ,  Color(1, 1, 1, 1) , 0.4)

func _physics_process(delta: float) -> void:
	$".".rotation = -get_parent().rotation
