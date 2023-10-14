class_name z_packed_int32_array extends Zodot

func _valid_type(value: Variant) -> bool:
	return typeof(value) == TYPE_PACKED_INT32_ARRAY

func parse(value: Variant, field: String) -> ZodotResult:
	if not _valid_type(value):
		return ZodotResult.type_error(field)
		
	return ZodotResult.ok()
