class_name GameApp extends Node


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
				paused_game.hide();
				game_paused.emit();
			State.PAUSED:
				get_tree().paused = true;
				paused_game.show();
				game_unpaused.emit();

var _input_manager_data: InputManagerData;
var _pause_menu_data: PauseMenuData;


## onready Variables
@onready var input_manager: InputManager = $InputManager;
@onready var paused_game: PausedGame = $PausedGame;
@onready var live_game: LiveGame = $LiveGame;


## Built-In Virtual Methods
func _ready() -> void:
	_state = State.PAUSED;
	_process_data();

func _process(_delta: float) -> void:
	pass


## Public Methods
func config(pause_menu_data: PauseMenuData) -> void:
	# Input Manager
	_input_manager_data = InputManagerData.new();
	_input_manager_data.pause_action_callback = pause_game;
	_input_manager_data.unpause_action_callback = unpause_game;
	
	# Pause Menu
	pause_menu_data.resume_button_callback = unpause_game;
	_pause_menu_data = pause_menu_data;
	
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
		paused_game.config(_pause_menu_data);
