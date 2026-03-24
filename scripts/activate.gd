extends Area2D

enum Sign { POSITIVE, NEGATIVE }
@export var sign: Sign
@export var field: Node2D
@export var block: Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	field.deactivate_field()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.sign == sign:
			# success
			field.activate_field()
			if block: block.enabled = false


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.sign == sign:
			# success
			field.deactivate_field()
			if block: block.enabled = true
