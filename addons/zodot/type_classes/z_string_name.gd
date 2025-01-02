class_name z_string_name extends Zodot

var _non_empty = false
var _max
var _min
	
func _valid_type(value: Variant) -> bool:
	return typeof(value) == TYPE_STRING_NAME
	
func non_empty() -> z_string_name:
	_non_empty = true
	return self
	
func minimum(m: int) -> z_string_name:
	_min = m
	return self
	
func maximum(m: int) -> z_string_name:
	_max = m
	return self

func parse(value: Variant, field: Variant = "") -> ZodotResult:
	if _coerce and typeof(value) == TYPE_STRING:
		value = str_to_var(value)
		
	if _nullable and value == null:
		return ZodotResult.good(value)
	
	if not _valid_type(value):
		return ZodotResult.type_error(field)
		
	if _non_empty and value == "":
		return ZodotResult.constraint_error(field, "Value must not be empty")
		
	if _min != null and len(value) < _min:
		return ZodotResult.constraint_error(field, "Value {value} length is smaller than min {min}".format({ "value": value, "min": _min }))
		
	if _max != null and len(value) > _max:
		return ZodotResult.constraint_error(field, "Value {value} length is larger than max {max}".format({ "value": value, "max": _max }))
		
	return ZodotResult.good(value)
