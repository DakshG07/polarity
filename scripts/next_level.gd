extends Area2D

enum Sign { POSITIVE, NEGATIVE }
@export var sign: Sign
@onready var level: Node2D = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.sign == sign:
			print("match")
			if sign == Sign.POSITIVE: level.positive_ready = true
			else: level.negative_ready = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.sign == sign:
			if sign == Sign.POSITIVE: level.positive_ready = false
			else: level.negative_ready = false
