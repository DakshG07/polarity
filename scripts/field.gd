extends Area2D

@export var field_direction: Vector2
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func deactivate_field():
	collision_shape_2d.set_deferred("disabled", true)
	visible = false

func activate_field():
	collision_shape_2d.set_deferred("disabled", false)
	visible = true


func _on_body_entered(body):
	print(body.name)
	if body.is_in_group("player"):
		body.field_direction = field_direction.normalized()
		body.in_field = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.field_direction = Vector2.ZERO
		body.in_field = false
		
