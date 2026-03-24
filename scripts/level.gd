extends Node2D

@onready var p1: CharacterBody2D = $Positive
@onready var p2: CharacterBody2D = $Negative
@export var nextScene: String

var positive_ready = false
var negative_ready = false

func respawn():
	p1.respawn()
	p2.respawn()

func _process(delta: float) -> void:
	if positive_ready && negative_ready:
		print("moving on to next level")
		get_tree().change_scene_to_file("res://scenes/" + nextScene + ".tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
