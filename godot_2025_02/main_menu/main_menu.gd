class_name MainMenu extends Node


## Private Variables
var _main_menu_data: MainMenuData;


## onready Variables
@onready var start_button: Button = $Control/MainMenuButtons/Start;
@onready var load_button: Button = $Control/MainMenuButtons/Load;
@onready var settings_button: Button = $Control/MainMenuButtons/Settings;
@onready var quit_button: Button = $Control/MainMenuButtons/Quit;


## Built-In Virtual Methods
func _ready() -> void:
	_process_main_menu_data();

func _process(_delta: float) -> void:
	pass


## Public Methods
func config(main_menu_data: MainMenuData) -> void:
	_main_menu_data = main_menu_data;
	if is_node_ready():
		_process_main_menu_data();

## Private Methods
func _process_main_menu_data() -> void:
	if _main_menu_data:
		start_button.button_up.connect(_main_menu_data.start_button_callback);
		load_button.button_up.connect(_main_menu_data.load_button_callback);
		settings_button.button_up.connect(_main_menu_data.settings_button_callback);
		quit_button.button_up.connect(_main_menu_data.quit_button_callback);
