extends Node2D

@export var m_HatMoveSpeed: float = 100
@export var m_HatPrefab: PackedScene

@export var m_HatParent: Node2D
@export var m_SpawnPosLeft: Node2D
@export var m_SpawnPosRight: Node2D
@export var m_HitPosIndicator: Node2D


var m_PlacedHats: Array[HatCtrl] = []
var m_ActiveHat: HatCtrl = HatCtrl.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Spawn Hat on either the left of the right
	m_ActiveHat = m_HatPrefab.instantiate()
	m_HatParent.add_child(m_ActiveHat)
	m_ActiveHat.global_position = m_SpawnPosLeft.global_position
	
	print("Spawned Hat")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	# Move hat towards opposite side that it spawnned
	m_ActiveHat.global_position = m_ActiveHat.global_position.move_toward(m_SpawnPosRight.global_position, delta * m_HatMoveSpeed)
	#m_ActiveHat.global_position.lerp(m_SpawnPosRight.global_position, 0.5)
	print("Moving Hat" + str(m_ActiveHat.global_position))
	
	# Check if the player inputs to stop the hat at the correct time (or within a margin of error)
	# If they do; stop the hat from moving, add it to the PlacedHats array, and move it to a new Parent node for PlacedHats
	# If they dont; Fade the hat out then deinstantiate it
	
	# Once the hat has been placed or deleted, Start process again
	
	
	
	pass
