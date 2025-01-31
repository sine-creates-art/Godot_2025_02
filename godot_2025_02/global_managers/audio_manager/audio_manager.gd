class_name AudioManager extends Node


## Enums
enum Music {NONE, GRAVITY, PEDAL_TO_THE_MEDAL};
enum SFX {NONE, MENU_BUTTON_HOVER};


## Constants
const music__gravity__aavirall: AudioStream = preload("res://assets/audio/music/gravity-aavirall-main-version-01-41-13965.mp3");
const music__pedal_to_the_metal__matrika: AudioStream = preload("res://assets/audio/music/pedal-to-the-metal-matrika-main-version-02-20-12120.mp3");

const sfx__menu_button_hover: AudioStream = preload("res://assets/audio/sfx/219069__annabloom__click1.wav");


## onready Variables
@onready var music_asp: AudioStreamPlayer = $Music_ASP;
@onready var sfx_asp: AudioStreamPlayer = $SFX_ASP;


## Built-In Virtual Methods
func _ready() -> void:
	music_asp.volume_db = -30.0;
	sfx_asp.volume_db = -20.0;
	Global.audio_manager = self;

func _process(_delta: float) -> void:
	pass


## Public Methods
func play_music(music_option: Music) -> void:
	music_asp.stop();
	if music_option == Music.NONE:
		music_asp.stream = null;
	music_asp.stream = _get_music_stream(music_option);
	music_asp.play();

func play_sfx(sfx_option: SFX) -> void:
	sfx_asp.stop();
	if sfx_option == SFX.NONE:
		sfx_asp.stream = null;
	sfx_asp.stream = _get_sfx_stream(sfx_option);
	sfx_asp.play();


## Private Methods
func _get_music_stream(music_option: Music) -> AudioStream:
	match music_option:
		Music.GRAVITY:
			return music__gravity__aavirall;
		Music.PEDAL_TO_THE_MEDAL:
			return music__pedal_to_the_metal__matrika;
	return null;

func _get_sfx_stream(sfx_option: SFX) -> AudioStream:
	match sfx_option:
		SFX.MENU_BUTTON_HOVER:
			return sfx__menu_button_hover;
	return null;
