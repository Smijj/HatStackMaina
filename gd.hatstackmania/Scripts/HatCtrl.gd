class_name HatCtrl
extends Node2D

enum HatStates {
	NONE,
	MOVING,
	PLACED
}

signal HatDone(wasSuccessful:bool)

@export_group("Settings")
@export var m_TravelTime: float = 1
@export var m_TravelTimeCounter: float = 0
@export var m_MoveSpeed: float = 400

@export_group("Refs")
@export var m_HatSprite: Sprite2D

var m_HatState: HatStates = HatStates.NONE
var m_TargetPos: Vector2 = Vector2.ZERO
var m_StartPos: Vector2 = Vector2.ZERO
var m_EndPos: Vector2 = Vector2.ZERO

#func _ready() -> void:
	#GameManager.GameOver.connect(Destroy)

func _process(delta: float) -> void:
	# Move Hat based on state
	if m_HatState == HatStates.MOVING:
		global_position = lerp(m_StartPos, m_EndPos, m_TravelTimeCounter/m_TravelTime)
		
		if m_TravelTimeCounter < m_TravelTime:
			m_TravelTimeCounter += delta
		else: 
			Destroy()

		#global_position = global_position.move_toward(m_EndPos, m_MoveSpeed * delta)

func Init(hatSprite: Texture, target: Vector2, startPos: Vector2, endPos: Vector2) -> Signal:
	m_HatSprite.texture = hatSprite
	m_TargetPos = target
	m_StartPos = startPos
	m_EndPos = endPos
	
	m_HatState = HatStates.MOVING
	
	return HatDone

func Stop(errorMargin: float = 0) -> bool:
	if IsSuccessful(errorMargin):
		m_HatState = HatStates.PLACED
		HatDone.emit(true)
		return true
	
	# Destroy Hat
	Destroy()
	return false

func IsSuccessful(errorMargin: float = 0) -> bool:
	if _GetDistanceFromTarget() > errorMargin: 
		return false
	return true

func _GetDistanceFromTarget() -> float:
	var distance: float = global_position.distance_to(m_TargetPos)
	print('Distance to Target' + str(distance))
	return distance

func Destroy() -> void:
	HatDone.emit(false)
	queue_free()
