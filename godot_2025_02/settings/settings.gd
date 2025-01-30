class_name Settings extends Node


## Private Variables
var _settings_data: SettingsData;


## onready Variables
@onready var control: Control = $Control;
@onready var back_button: Button = $Control/Panel/Back;


## Built-In Virtual Methods
func _ready() -> void:
	_process_settings_data();

func _process(_delta: float) -> void:
	pass


## Public Methods
func config(settings_data: SettingsData) -> void:
	_settings_data = settings_data;
	if is_node_ready():
		_process_settings_data();

func hide() -> void:
	control.visible = false;

func show() -> void:
	control.visible = true;


## Private Methods
func _process_settings_data() -> void:
	if _settings_data:
		Utility.clear_connections(back_button.button_up);
		back_button.button_up.connect(_settings_data.back_button_callback);
