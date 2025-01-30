class_name Utility

static func clear_connections(a_signal: Signal) -> void:
	var connections: Array = a_signal.get_connections();
	for connection in connections:
		a_signal.disconnect(connection.callable);
