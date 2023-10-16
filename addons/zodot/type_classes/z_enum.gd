class_name z_enum extends Zodot

static func get_enum_value(key, e):
	var value = null

	if typeof(key) == TYPE_STRING:
		var converted = key.to_upper().replace(' ', '_')
		if e.keys().has(converted):
			value = e[converted]
	else:
		if e.values().has(key):
			value = key

	return value

var _enum

func _init(enum_type: Variant):
	_enum = enum_type

func parse(value: Variant, field: String = "") -> ZodotResult:
	if _coerce and typeof(value) == TYPE_STRING:
		value = str_to_var(value)
		
	if _nullable and value == null:
		return ZodotResult.good(value)
		
	if get_enum_value(value, _enum) == null:
		return ZodotResult.constraint_error(field, "Value is not valid enum member")
		
	return ZodotResult.good(value)
