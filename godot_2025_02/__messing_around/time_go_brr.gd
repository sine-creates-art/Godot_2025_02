extends Control

@onready var label: Label = $Label;
var initial_time: int;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_time = Time.get_ticks_msec();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label.text = str(Time.get_ticks_msec() - initial_time);
