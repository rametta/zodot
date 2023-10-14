class_name z_vector4i extends Zodot

func _valid_type(value: Variant) -> bool:
	return typeof(value) == TYPE_VECTOR4I

func parse(value: Variant, field: String) -> ZodotResult:
	if not _valid_type(value):
		return ZodotResult.type_error(field)
		
	return ZodotResult.ok()
