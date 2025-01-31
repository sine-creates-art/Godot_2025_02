extends Control


## Private Variables
var duration: float = 0.0;

## onready Variables
@onready var label: Label = $Label;


## Built-In Virtual Methods
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	duration += _delta;
	var seconds: int = floor(int(duration));
	var remainder: int = floor(100.0*(duration - float(seconds)));
	if (remainder < 10):
		label.text = str(seconds) + ":0" + str(remainder);
	else:
		label.text = str(seconds) + ":" + str(remainder);
