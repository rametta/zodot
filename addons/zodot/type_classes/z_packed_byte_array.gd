class_name z_packed_byte_array extends Zodot

func _valid_type(value: Variant) -> bool:
	return typeof(value) == TYPE_PACKED_BYTE_ARRAY

func parse(value: Variant, field: String = "") -> ZodotResult:
	if _coerce and typeof(value) == TYPE_STRING:
		value = str_to_var(value)
		
	if _nullable and value == null:
		return ZodotResult.good(value)
	
	if not _valid_type(value):
		return ZodotResult.type_error(field)
		
	return ZodotResult.good(value)
