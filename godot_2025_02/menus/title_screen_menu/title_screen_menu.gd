class_name TitleScreenMenu extends Node


## Private Variables
var _main_menu_data: MainMenuData;


## onready Variables
@onready var control: Control = $Control;
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

func hide() -> void:
	control.visible = false;

func show() -> void:
	control.visible = true;


## Private Methods
func _process_main_menu_data() -> void:
	if _main_menu_data:
		Utility.clear_connections(start_button.button_up);
		start_button.button_up.connect(_main_menu_data.start_button_callback);
		Utility.clear_connections(load_button.button_up);
		load_button.button_up.connect(_main_menu_data.load_button_callback);
		Utility.clear_connections(settings_button.button_up);
		settings_button.button_up.connect(_main_menu_data.settings_button_callback);
		Utility.clear_connections(quit_button.button_up);
		quit_button.button_up.connect(_main_menu_data.quit_button_callback);
