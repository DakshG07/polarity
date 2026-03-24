extends CharacterBody2D

@export var player: String
@onready var positive: AnimatedSprite2D = $Positive
@onready var negative: AnimatedSprite2D = $Negative
@onready var level: Node2D = $".."

var animated_sprite_2d: AnimatedSprite2D

enum Sign { POSITIVE, NEGATIVE }
@export var sign: Sign

var field_direction: Vector2
var in_field = false

var respawn_position: Vector2

const SPEED = 300.0
const JUMP_VELOCITY = -550.0

func _ready():
	respawn_position = global_position
	update_sprite()

func respawn():
	global_position = respawn_position
	velocity = Vector2.ZERO
	
func swap():
	if sign == Sign.POSITIVE:
		sign = Sign.NEGATIVE
	else:
		sign = Sign.POSITIVE
	update_sprite()

func update_sprite():
	if sign == Sign.POSITIVE:
		animated_sprite_2d = positive
		positive.visible = true
		negative.visible = false
	else:
		animated_sprite_2d = negative
		positive.visible = false
		negative.visible = true

func _physics_process(delta: float) -> void:
	
	# Animations
	if !is_on_floor():
		animated_sprite_2d.animation = "jump"
	elif velocity.x != 0:
		animated_sprite_2d.animation = "walk"
	else:
		animated_sprite_2d.animation = "idle"
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(player + "jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(player + "left", player + "right")
	if direction:
		velocity.x = direction * SPEED
	elif in_field:
		velocity.x = 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Field
	if in_field:
		if sign == Sign.POSITIVE:
			velocity += 2 * SPEED * field_direction
		else:
			velocity += -2 * SPEED * field_direction
	velocity = velocity.limit_length(3 * SPEED)

	move_and_slide()
	
	# Flip player
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true
		
	# Check respawn
	if global_position.y > 800:
		level.respawn()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("swap"):
		swap()
