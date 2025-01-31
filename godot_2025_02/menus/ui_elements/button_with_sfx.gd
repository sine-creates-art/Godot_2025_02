class_name ButtonWithSfx extends Button


## export Variables
@export var hover_sfx: AudioManager.SFX = AudioManager.SFX.MENU_BUTTON_HOVER;


## Built-In Virtual Methods
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered);

func _process(_delta: float) -> void:
	pass


## Private Methods
func _on_mouse_entered() -> void:
	if Global.audio_manager:
		Global.audio_manager.play_sfx(hover_sfx);
