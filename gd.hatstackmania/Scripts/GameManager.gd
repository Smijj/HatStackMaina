extends Node

var GameState = GameStates.START
enum GameStates {
	START,
	PLAYING
}

signal GameStart
signal GameOver
signal HealthChanged(newValue: int)
signal HatStackCounterChanged(newValue: int)

var IsGameOver: bool:
	get: return GameState == GameStates.START
var MaxHealth: int = 3
var GameOverTimer: float = 0.5
var GameOverTimerCounter: float = 0

var _Health: int = 3
var Health: int:
	get: return _Health
	set(value): 
		if GameState != GameStates.PLAYING: return
		
		_Health = value
		HealthChanged.emit(value)
		
		if value <= 0: EndGame()
	
var _HatStackCounter: int = 0
var HatStackCounter: int:
	get: return _HatStackCounter
	set(value): 
		if GameState != GameStates.PLAYING: return
		_HatStackCounter = value
		HatStackCounterChanged.emit(value)

func _process(delta: float) -> void:
	if GameState == GameStates.START && GameOverTimerCounter < GameOverTimer:
		GameOverTimerCounter += delta

func _input(event: InputEvent) -> void:
	if GameOverTimerCounter < GameOverTimer: return
	if GameState == GameStates.PLAYING: return
	if GameState == GameStates.START && event.is_action_pressed("MainInput"):
		StartGame()

func StartGame() -> void:
	GameState = GameStates.PLAYING
	Health = MaxHealth
	HatStackCounter = 0
	
	GameStart.emit()

func EndGame() -> void:
	GameOverTimerCounter = 0
	GameState = GameStates.START
	
	GameOver.emit()
