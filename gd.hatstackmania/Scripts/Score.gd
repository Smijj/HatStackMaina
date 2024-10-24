extends Label

func _ready() -> void:
	GameManager.HatStackCounterChanged.connect(OnScoreChanged)

func OnScoreChanged(newValue: int) -> void:
	text = str(newValue)
