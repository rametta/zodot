class_name z_string extends Zodot

var _non_empty = false
var _max
var _min
	
func _valid_type(value: Variant) -> bool:
	return typeof(value) == TYPE_STRING
	
func non_empty() -> z_string:
	_non_empty = true
	return self
	
func minimum(m: int) -> z_string:
	_min = m
	return self
	
func maximum(m: int) -> z_string:
	_max = m
	return self

func parse(value: Variant, field: String) -> ZodotResult:
	if not _valid_type(value):
		return ZodotResult.type_error(field)
		
	if _non_empty:
		if value == "":
			return ZodotResult.empty_error(field)
		
		
	if _min != null:
		if len(value) < _min:
			return ZodotResult.min_error(field)
			
	if _max != null:
		if len(value) > _max:
			return ZodotResult.max_error(field)
		
	return ZodotResult.ok()
