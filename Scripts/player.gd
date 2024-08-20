extends CharacterBody2D


@export var SPEED :int = 300.0 
@onready var animation := $AnimationTree
#var my_velocity:=velocity
var player_name = "" 

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
	if is_multiplayer_authority():
		$Camera2D.enabled = true
	
func _physics_process(delta: float) -> void:
	animation.set("parameters/Movement/blend_position",velocity)
	if velocity.x!=0:
		animation.set("parameters/Left-Right/blend_position",velocity.x);

	if not is_multiplayer_authority():
		return
	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
