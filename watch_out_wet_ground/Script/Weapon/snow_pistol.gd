extends Area2D

@export var shoot_momentum = 10.0
var owner_name = ""
const Bullet = preload("res://Object/Weapon/Bullet.tscn")
var is_picked = false
	

func _process(delta):
	if is_picked:
		var mouse_position_g = get_global_mouse_position()
		scale.y = 1 if (mouse_position_g - global_position).x > 0 else -1
		look_at(mouse_position_g)
		if Input.is_action_pressed("player_shoot"):
			var bullet_node = Bullet.instantiate()
			bullet_node.momentum = shoot_momentum
			bullet_node.bullet_velocity = mouse_position_g - global_position
			print(bullet_node.bullet_velocity)
			bullet_node.global_position = $Marker2D.global_position
			bullet_node.owner_name = owner_name
			get_tree().root.add_child(bullet_node)
			#a = false
func pick_up(parent:Node ,parent_name ,scale = 1.2):
	call_deferred("reparent" ,parent ,false)
	scale = Vector2(scale ,scale)
	position = Vector2.ZERO
	is_picked = true
	get_node("CollisionShape2D").set_deferred("disabled" ,true)
	owner_name = parent_name
