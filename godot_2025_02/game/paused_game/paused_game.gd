class_name PausedGame extends Node


## Enums
enum State {NONE, PAUSE_SCREEN, SETTINGS};


## Private Variables
var _state: State = State.NONE:
	set(value):
		if (_state == value):
			return;
		_state = value;
		
		pause_menu.hide();
		settings_menu.hide();
		match _state:
				State.PAUSE_SCREEN:
					pause_menu.show();
				State.SETTINGS:
					settings_menu.show();

var _pause_menu_data: PauseMenuData;


## onready Variables
@onready var pause_menu: PauseMenu = $PauseMenu;
@onready var settings_menu: SettingsMenu = $SettingsMenu;


## Built-In Virtual Methods
func _ready() -> void:
	_process_pause_menu_data();
	show();

func _process(_delta: float) -> void:
	pass


## Public Methods
func config(pause_menu_data: PauseMenuData) -> void:
	_pause_menu_data = pause_menu_data;
	if is_node_ready():
		_process_pause_menu_data();

func show() -> void:
	_state = State.PAUSE_SCREEN;

func hide() -> void:
	_state = State.NONE;


## Private Methods
func _process_pause_menu_data() -> void:
	if _pause_menu_data:
		# Title Screen
		_pause_menu_data.settings_button_callback = _settings_open_action;
		pause_menu.config(_pause_menu_data);
		
		# Settings
		var settings_menu_data: SettingsMenuData = SettingsMenuData.new();
		settings_menu_data.back_button_callback = _settings_back_action;
		settings_menu.config(settings_menu_data);

func _settings_open_action() -> void:
	_state = State.SETTINGS;

func _settings_back_action() -> void:
	_state = State.PAUSE_SCREEN;
