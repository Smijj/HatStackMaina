extends HBoxContainer

@export_group('Settings')
@export var m_HealthyColour: Color = Color.RED
@export var m_UnhealthyColour: Color = Color.DIM_GRAY

@export_group('Refs')
@export var m_HeartSprite: Texture

var m_Hearts: Array[TextureRect]

func _ready() -> void:
	GameManager.GameStart.connect(InitHealthBar)
	GameManager.GameOver.connect(ClearHealthBar)
	GameManager.HealthChanged.connect(OnHealthChanged)

func OnHealthChanged(newValue: int) -> void:
	if m_Hearts.size() <= 0: return
	if newValue < 0: return
	
	# Set heart in array to unhealthy colour
	m_Hearts[newValue].self_modulate = m_UnhealthyColour

func InitHealthBar() -> void:
	for i in GameManager.MaxHealth:
		print(i)
		var heart: TextureRect = TextureRect.new()
		heart.texture = m_HeartSprite
		heart.self_modulate = m_HealthyColour
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		heart.custom_minimum_size = Vector2(50, 0)
		m_Hearts.append(heart)
		add_child(heart)

func ClearHealthBar() -> void:
	if m_Hearts.size() <= 0: return
	for heart in m_Hearts:
		heart.queue_free()
	m_Hearts.clear()
