class_name HatCtrl
extends Node2D

enum HatStates {
	None,
	Moving,
	Placed
}

@onready var m_HatSprite: Sprite2D = $Sprite2D

@export var m_MoveSpeed: float = 400
@export var m_PossibleHatSprites: Array[Texture]

var m_HatState: HatStates = HatStates.None
var m_TargetPos: Vector2
var m_EndPos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Move Hat based on state
	if m_HatState == HatStates.Moving:
		global_position = global_position.move_toward(m_EndPos, m_MoveSpeed * delta)
	
	pass

func Init(target: Vector2, endPos: Vector2) -> void:
	m_HatState = HatStates.Moving
	
	pass

func Stop() -> void:
	m_HatState= HatStates.Placed
	
	pass
