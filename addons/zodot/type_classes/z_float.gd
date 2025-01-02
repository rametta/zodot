class_name z_float extends Zodot

var _max
var _min
	
func _valid_type(value: Variant) -> bool:
	return typeof(value) == TYPE_FLOAT
	
func minimum(m: float) -> z_float:
	_min = m
	return self
	
func maximum(m: float) -> z_float:
	_max = m
	return self

func parse(value: Variant, field: Variant = "") -> ZodotResult:
	if _coerce and typeof(value) == TYPE_STRING:
		value = str_to_var(value)
		
	if _nullable and value == null:
		return ZodotResult.good(value)
	
	if not _valid_type(value):
		return ZodotResult.type_error(field)
		
	if _min != null and value < _min:
		return ZodotResult.constraint_error(field, "Value {value} smaller than min {min}".format({ "value": value, "min": _min }))
			
	if _max != null and value > _max:
		return ZodotResult.constraint_error(field, "Value {value} larger than max {max}".format({ "value": value, "max": _max }))
		
	return ZodotResult.good(value)
