class_name PauseMenu extends Node


## Private Variables
var _pause_menu_data: PauseMenuData;


## onready Variables
@onready var control: Control = $Control;
@onready var resume_button: Button = $Control/PauseMenuButtons/Resume;
@onready var settings_button: Button = $Control/PauseMenuButtons/Settings;
@onready var main_menu_button: Button = $Control/PauseMenuButtons/MainMenu;


## Built-In Virtual Methods
func _ready() -> void:
	_process_pause_menu_data();

func _process(_delta: float) -> void:
	pass


## Public Methods
func config(pause_menu_data: PauseMenuData) -> void:
	_pause_menu_data = pause_menu_data;
	if is_node_ready():
		_process_pause_menu_data();

func hide() -> void:
	control.visible = false;

func show() -> void:
	control.visible = true;


## Private Methods
func _process_pause_menu_data() -> void:
	if _pause_menu_data:
		resume_button.button_up.connect(_pause_menu_data.resume_button_callback);
		settings_button.button_up.connect(_pause_menu_data.settings_button_callback);
		main_menu_button.button_up.connect(_pause_menu_data.main_menu_button_callback);
