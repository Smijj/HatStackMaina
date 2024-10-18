extends Node2D

@export var m_SpawnPosLeft: Node2D
@export var m_SpawnPosRight: Node2D
@export var m_HitPosIndicator: Node2D

var m_PlacedHats: Array[Node2D] = []
var m_ActiveHat: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Spawn Hat on either the left of the right
	
	# Move hat towards opposite side that it spawnned
	
	# Check if the player inputs to stop the hat at the correct time (or within a margin of error)
	# If they do; stop the hat from moving, add it to the PlacedHats array, and movw it to a new Parent node for PlacedHats
	# If they dont; Fade the hat out then deinstantiate it
	
	# Once the hat has been placed or deleted, Start process again
	
	pass
