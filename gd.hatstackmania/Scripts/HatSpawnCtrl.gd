extends Node2D

@export_group("Settings")
@export var m_InputMarginOfErrorInPixels: float = 100
@export var m_SuccessfulHatMoveDownIncrement: float = 150
@export var m_HatPrefab: PackedScene
@export var m_PossibleHatSprites: Array[Texture]

@export_group("Refs")
@export var m_LilMan: Node2D
@export var m_HatParent: Node2D
@export var m_SpawnPosLeft: Node2D
@export var m_SpawnPosRight: Node2D
@export var m_HitPosIndicator: Sprite2D
@export var m_AudioStream: AudioStreamPlayer2D


var m_PlacedHats: Array[HatCtrl] = []
var m_ActiveHat: HatCtrl = HatCtrl.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.GameStart.connect(OnGameStart)
	GameManager.GameOver.connect(OnGameOver)

func OnGameStart() -> void:
	SpawnHat()

func OnGameOver() -> void:
	m_ActiveHat.Destroy()
	m_ActiveHat = null
	for hat in m_PlacedHats:
		hat.Destroy()
	m_PlacedHats.clear()
	
	if m_LilMan: m_LilMan.global_position.y = 0

func _input(event: InputEvent) -> void:
	# Check if the player inputs to stop the hat at the correct time (or within a margin of error)
	# If they do; stop the hat from moving, add it to the PlacedHats array, and move it to a new Parent node for PlacedHats
	# If they dont; Fade the hat out then deinstantiate it
	if event.is_action_pressed("MainInput"):
		if m_ActiveHat != null: m_ActiveHat.Stop(m_InputMarginOfErrorInPixels)
		if m_AudioStream: m_AudioStream.play()
		

func SpawnHat() -> void:
	# Select Random Hat Sprite
	var hatSprite: Texture = m_PossibleHatSprites.pick_random()
	
	# Set the Hat Indicator texture
	m_HitPosIndicator.texture = hatSprite
	
	# Spawn Hat on either the left of the right
	var spawnPos: Vector2
	var endPos: Vector2
	if randi_range(0, 1) == 0:
		spawnPos = m_SpawnPosLeft.global_position 
		endPos = m_SpawnPosRight.global_position 
	else:
		spawnPos = m_SpawnPosRight.global_position 
		endPos = m_SpawnPosLeft.global_position
	
	# Instantiate new Hat Object and make it a child of the HatParent Node
	m_ActiveHat = m_HatPrefab.instantiate()
	m_HatParent.add_child(m_ActiveHat)
	m_ActiveHat.global_position = spawnPos
	m_ActiveHat.Init(hatSprite, m_HitPosIndicator.global_position, spawnPos, endPos).connect(OnActiveHatDone)

func OnActiveHatDone(wasSuccessful: bool) -> void:
	# If the game is over dont continue the game
	if GameManager.IsGameOver: 
		return
	
	if wasSuccessful:
		if m_ActiveHat: m_PlacedHats.append(m_ActiveHat)
		if m_LilMan: m_LilMan.global_position.y += m_SuccessfulHatMoveDownIncrement
		GameManager.HatStackCounter += 1
		print("Was Successful")
	else:
		GameManager.Health -= 1
		print("Was Not Successful")
	
	# This check is here because the game ends when the Health Var in gets set to 0, then this happens afterwards which breaks a bunch of stuff
	if GameManager.Health > 0: 
		# Once the hat has been placed or deleted, Start process again
		m_ActiveHat = null
		SpawnHat()
