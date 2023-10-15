class_name z_float extends Zodot

var _max
var _min
	
func _valid_type(value: Variant) -> bool:
	return typeof(value) == TYPE_FLOAT
	
func minimum(m: int) -> z_float:
	_min = m
	return self
	
func maximum(m: int) -> z_float:
	_max = m
	return self

func parse(value: Variant, field: String = "") -> ZodotResult:
	if _coerce:
		value = str_to_var(value)
		
	if _nullable and value == null:
		return ZodotResult.ok(value)
	
	if not _valid_type(value):
		return ZodotResult.type_error(field)
		
	if _min != null:
		if value < _min:
			return ZodotResult.min_error(field)
			
	if _max != null:
		if value > _max:
			return ZodotResult.max_error(field)
		
	return ZodotResult.ok(value)
