class_name Root extends Node


## Signals
signal game_started()
signal game_stopped()


## Enums
enum State {NONE, MAIN_MENU, LOADING, STARTING, RUNNING, SAVING, STOPPING};


## onready Variables
@onready var active_scene_parent = $ActiveSceneParent;


## Private Variables
var _state: State = State.NONE:
	set(value):
		if (_state == value || value == State.NONE):
			return;
		_state = value;
		match _state:
			State.MAIN_MENU:
				_clear_active_scene();
				_generate_main_menu();
			State.STARTING:
				_clear_active_scene();
				_generate_game();
				_state = State.RUNNING;
			State.RUNNING:
				pass
			State.SAVING:
				pass
			State.STOPPING:
				game_stopped.emit();
				#await get_tree().create_timer(1.0).timeout;
				get_tree().quit();


## Built-In Virtual Methods
func _ready() -> void:
	_state = State.MAIN_MENU;
	# load settings
	# player data
	pass


func _process(_delta: float) -> void:
	pass


## Public Methods
func go_to_main_menu() -> void:
	_state = State.MAIN_MENU;

func load_game() -> void:
	match _state:
		State.MAIN_MENU:
			# load game, but don't start (e.g., selecting a certain save)
			pass;
		State.RUNNING:
			# stop -> load -> start game...
			pass;

func start_game() -> void:
	if (_state == State.MAIN_MENU):
		_state = State.STARTING;

func save_game() -> void:
	if (_state == State.RUNNING):
		# save game
		pass

func quit_game() -> void:
	if (_state == State.MAIN_MENU):
		_state = State.STOPPING;


## Private Methods
func _clear_active_scene() -> void:
	var active_scenes = active_scene_parent.get_children();
	for active_scene in active_scenes:
		active_scene_parent.remove_child(active_scene);
		active_scene.queue_free();

func _generate_main_menu() -> void:
	var main_menu_data: MainMenuData = MainMenuData.new();
	main_menu_data.start_button_callback = start_game;
	main_menu_data.load_button_callback = load_game;
	main_menu_data.settings_button_callback = Function.do_nothing;
	main_menu_data.quit_button_callback = quit_game;
	var main_menu: MainMenu = SceneFactory.new_main_menu(main_menu_data);
	active_scene_parent.add_child(main_menu);

func _generate_game() -> void:
	var pause_menu_data: PauseMenuData = PauseMenuData.new();
	pause_menu_data.settings_button_callback = Function.do_nothing;
	pause_menu_data.main_menu_button_callback = go_to_main_menu;
	var game: Game = SceneFactory.new_game(pause_menu_data);
	active_scene_parent.add_child(game);
	game_started.emit();
