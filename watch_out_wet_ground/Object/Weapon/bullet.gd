extends Area2D
@export var lifetime = 1.0
var owner_name = ""
var momentum = 15.0
var bullet_velocity = Vector2.ZERO

func _physics_process(delta):
	position += bullet_velocity * delta

func _ready():
	pass
	#$AnimatedSprite2D.play("default")
	#await get_tree().create_timer(lifetime)
	#$CollisionShape2D.set_deferred("disabled" ,true)
	#$AnimatedSprite2D.play("mealt")
	#await $AnimatedSprite2D.animation_finished
	#queue_free()

func on_hit_player(body):
	if body.name != owner_name:
		print(name,":",bullet_velocity)
		body.hitted(momentum ,bullet_velocity)
		print(bullet_velocity)
		# TODO 在此处写入雪球击中玩家时破碎的动画
		queue_free()
