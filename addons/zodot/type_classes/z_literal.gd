class_name z_literal extends Zodot

var _value: Variant

func _init(value: Variant):
	_value = value

func _valid_type(value: Variant) -> bool:
	return true

func parse(value: Variant, field: Variant = "") -> ZodotResult:
	if _coerce and typeof(value) == TYPE_STRING:
		value = str_to_var(value)
	
	if _nullable and value == null:
		return ZodotResult.good(value)
	
	if value == _value:
		return ZodotResult.good(value)
	
	return ZodotResult.constraint_error(field, "Value is not equal to literal")
