class_name InputManager extends Node


## Private Variables
var _input_manager_data: InputManagerData;

var _pause_action_callback: Callable;
var _unpause_action_callback: Callable;


## Built-In Virtual Methods
func _ready() -> void:
	_process_input_manager_data();

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var _callback: Callable = _unpause_action_callback if get_tree().paused else _pause_action_callback;
		_callback.call();


## Public Methods
func config(input_manager_data: InputManagerData) -> void:
	_input_manager_data = input_manager_data;
	if is_node_ready():
		_process_input_manager_data();

## Private Methods
func _process_input_manager_data() -> void:
	if _input_manager_data:
		_pause_action_callback = _input_manager_data.pause_action_callback;
		_unpause_action_callback = _input_manager_data.unpause_action_callback;
