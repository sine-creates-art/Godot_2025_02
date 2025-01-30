class_name SceneFactory


## Main Menu
const main_menu: PackedScene = preload("res://main_menu/main_menu.tscn");

static func new_main_menu(main_menu_data: MainMenuData) -> MainMenu:
	var new_main_menu_instance: MainMenu = main_menu.instantiate();
	new_main_menu_instance.config(main_menu_data);
	return new_main_menu_instance;


## Game
const game: PackedScene = preload("res://game/game.tscn");

static func new_game(pause_menu_data: PauseMenuData, settings: Settings) -> Game:
	var new_game_instance: Game = game.instantiate();
	new_game_instance.config(pause_menu_data, settings);
	return new_game_instance;
