class_name z_integer extends Zodot

var _max
var _min
	
func _valid_type(value: Variant) -> bool:
	return typeof(value) == TYPE_INT
	
func minimum(m: int) -> z_integer:
	_min = m
	return self
	
func maximum(m: int) -> z_integer:
	_max = m
	return self

func parse(value: Variant, field: String) -> ZodotResult:
	if not _valid_type(value):
		return ZodotResult.type_error(field)
		
	if _min != null:
		if value < _min:
			return ZodotResult.min_error(field)
			
	if _max != null:
		if value > _max:
			return ZodotResult.max_error(field)
		
	return ZodotResult.ok()
