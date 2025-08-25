extends RigidBody2D

@export var FORCE_LEN = 1.0 # 当按下键盘上的按键时，对玩家施加力的大小
var flip_or_not = false
var animate_sprite:AnimatedSprite2D

func _ready():
	animate_sprite = $AnimatedSprite2D
	animate_sprite.play("idle")

func _process(delta):
	flip_or_not = linear_velocity.x > 0
	animate_sprite.flip_h = flip_or_not
	
	if linear_velocity.length() < 2.0:
		animate_sprite.play("idle")
	else:
		animate_sprite.play("move")

func pick_up_weapon(weapon):
	#if Input.is_action_pressed("player_pick_up"):
	var weapons_already_had = $Marker2D.get_children()
	if weapons_already_had.size() == 0:
		weapon.call_deferred("reparent",$Marker2D,false)
		weapon.scale = Vector2(1.2 ,1.2)
		#weapon.reparent($Marker2D)
		weapon.position = Vector2.ZERO
		#print(weapon.position)
		weapon.is_picked = true
		weapon.get_node("CollisionShape2D").set_deferred("disabled" ,true)
		weapon.owner_name = name

func hitted(momentum:float ,add_linear_velocity:Vector2):
	add_linear_velocity = add_linear_velocity.normalized() * momentum # 这边可以写一点减少动量的道具代码
	linear_velocity += add_linear_velocity
	
