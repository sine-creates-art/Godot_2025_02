class_name Game extends Node


## Signals
signal game_paused()
signal game_unpaused()


## Enums
enum State {NONE, RUNNING, PAUSED};


## Private Variables
var _state: State = State.NONE:
	set(value):
		if (_state == value || value == State.NONE):
			return;
		_state = value;
		match _state:
			State.RUNNING:
				get_tree().paused = false;
				pause_menu.hide();
				game_paused.emit();
			State.PAUSED:
				get_tree().paused = true;
				pause_menu.show();
				game_unpaused.emit();

var _input_manager_data: InputManagerData;
var _pause_menu_data: PauseMenuData;
var _settings: Settings;


## onready Variables
@onready var input_manager: InputManager = $InputManager;
@onready var pause_menu: PauseMenu = $PauseMenu;
@onready var game_app: GameApp = $GameApp;


## Built-In Virtual Methods
func _ready() -> void:
	_state = State.PAUSED;
	_process_data();

func _process(_delta: float) -> void:
	pass


## Public Methods
func config(pause_menu_data: PauseMenuData, settings: Settings) -> void:
	# Input Manager
	_input_manager_data = InputManagerData.new();
	_input_manager_data.pause_action_callback = pause_game;
	_input_manager_data.unpause_action_callback = unpause_game;
	
	# Pause Menu
	pause_menu_data.resume_button_callback = unpause_game;
	pause_menu_data.settings_button_callback = _settings_open_action;
	_pause_menu_data = pause_menu_data;
	
	# Settings
	_settings = settings;
	var settings_data = SettingsData.new();
	settings_data.back_button_callback = _settings_back_action;
	_settings.config(settings_data);
	
	if is_node_ready():
		_process_data();

func pause_game() -> void:
	if (_state == State.RUNNING):
		_state = State.PAUSED;

func unpause_game() -> void:
	if (_state == State.PAUSED):
		_state = State.RUNNING;


## Private Methods
func _process_data() -> void:
	_process_input_manager_data();
	_process_pause_menu_data();

func _process_input_manager_data() -> void:
	if _input_manager_data:
		input_manager.config(_input_manager_data);

func _process_pause_menu_data() -> void:
	if _pause_menu_data:
		pause_menu.config(_pause_menu_data);

func _settings_open_action() -> void:
	pause_menu.hide();
	_settings.show();

func _settings_back_action() -> void:
	_settings.hide();
	pause_menu.show();
