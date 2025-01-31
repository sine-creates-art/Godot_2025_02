class_name MainMenuApp extends Node


## Enums
enum State {NONE, TITLE_SCREEN, SETTINGS};


## Private Variables
var _state: State = State.NONE:
	set(value):
		if (_state == value || value == State.NONE):
			return;
		_state = value;
		
		title_screen_menu.hide();
		settings_menu.hide();
		match _state:
				State.TITLE_SCREEN:
					title_screen_menu.show();
				State.SETTINGS:
					settings_menu.show();

var _main_menu_data: MainMenuData;


## onready Variables
@onready var title_screen_menu: TitleScreenMenu = $TitleScreenMenu;
@onready var settings_menu: SettingsMenu = $SettingsMenu;


## Built-In Virtual Methods
func _ready() -> void:
	_process_main_menu_data();
	_state = State.TITLE_SCREEN;

func _process(_delta: float) -> void:
	pass


## Public Methods
func config(main_menu_data: MainMenuData) -> void:
	
	## Main Menu
	_main_menu_data = main_menu_data;
	if is_node_ready():
		_process_main_menu_data();

func show() -> void:
	_state = State.TITLE_SCREEN;

func hide() -> void:
	_state = State.NONE;


## Private Methods
func _process_main_menu_data() -> void:
	if _main_menu_data:
		# Title Screen
		_main_menu_data.settings_button_callback = _settings_open_action;
		title_screen_menu.config(_main_menu_data);
		
		# Settings
		var settings_menu_data: SettingsMenuData = SettingsMenuData.new();
		settings_menu_data.back_button_callback = _settings_back_action;
		settings_menu.config(settings_menu_data);
	
	if Global.audio_manager:
		Global.audio_manager.play_music(AudioManager.Music.GRAVITY);

func _settings_open_action() -> void:
	_state = State.SETTINGS;

func _settings_back_action() -> void:
	_state = State.TITLE_SCREEN;
