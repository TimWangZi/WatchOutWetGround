extends Area2D
@export var is_picked = false

func _ready():
	pass

func _process(delta):
	if is_picked:
		look_at(get_global_mouse_position())
		

func area_triggered(body):
	print(body.name)
	if body.name.find("Player") != -1:
		body.pick_up_weapon(self)
		print("player picked snowball pistol")
			
