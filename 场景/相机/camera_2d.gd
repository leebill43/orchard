extends Camera2D

var target_position = Vector2(577,322)

func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previe.ous fram
func _process(delta):
	if Input.is_action_just_pressed("up"):
		target_position.y -= 100
	if Input.is_action_just_pressed("down"):
		target_position.y += 100
	if Input.is_action_just_pressed("left"):
		target_position.x -= 100
	if Input.is_action_just_pressed("right"):
		target_position.x += 100
	if Input.is_action_just_pressed("mouse_down"):
		zoom.x -= 0.1
		zoom.y -= 0.1
	if Input.is_action_just_pressed("mouse_up"):
		zoom.x += 0.1
		zoom.y += 0.1
	
	#acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 20))



#func acquire_target():
	#var player_nodes = get_tree().get_nodes_in_group("player")
	#if player_nodes.size() > 0:
		#var player = player_nodes[0] as Node2D
		#target_position = player.global_position
