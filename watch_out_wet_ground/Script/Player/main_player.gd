extends RigidBody2D

@export var FORCE_LEN = 1.0 # 当按下键盘上的按键时，对玩家施加力的大小
var flip_or_not = false
var animate_sprite:AnimatedSprite2D

func _ready():
	animate_sprite = $AnimatedSprite2D
	animate_sprite.play("idle")

func _process(delta):
	var force = Vector2.ZERO
	if Input.is_action_pressed("player_move_up"):
		force.y -= 1.0
	if Input.is_action_pressed("player_move_down"):
		force.y += 1.0
	if Input.is_action_pressed("player_move_left"):
		force.x -= 1.0
	if Input.is_action_pressed("player_move_right"):
		force.x += 1.0
	force = force.normalized() * FORCE_LEN # 力归一化并乘上力的大小
	
	flip_or_not = linear_velocity.x > 0
	animate_sprite.flip_h = flip_or_not
	
	if linear_velocity.length() < 2.0:
		animate_sprite.play("idle")
	else:
		animate_sprite.play("move")
	
	if force.length() > 0.0:
		add_constant_force(force) # 向刚体施加力
	else:
		constant_force = Vector2.ZERO # 清空物体的力

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
