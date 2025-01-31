class_name SceneFactory


## Main Menu
const main_menu_app: PackedScene = preload("res://apps/main_menu_app/main_menu_app.tscn");

static func new_main_menu_app(main_menu_data: MainMenuData) -> MainMenuApp:
	var new_main_menu_instance: MainMenuApp = main_menu_app.instantiate();
	new_main_menu_instance.config(main_menu_data);
	return new_main_menu_instance;


## Game
const game_app: PackedScene = preload("res://apps/game_app/game_app.tscn");

static func new_game_app(pause_menu_data: PauseMenuData) -> GameApp:
	var new_game_instance: GameApp = game_app.instantiate();
	new_game_instance.config(pause_menu_data);
	return new_game_instance;
