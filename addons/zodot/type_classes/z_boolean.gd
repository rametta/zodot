class_name z_boolean extends Zodot

enum Kind {
	ONLY_TRUE,
	ONLY_FALSE,
	BOTH
}

var _kind = Kind.BOTH

func _init(kind: Kind) -> void:
	_kind = kind

func _valid_type(value: Variant) -> bool:
	return typeof(value) == TYPE_BOOL

func parse(value: Variant, field: String = "") -> ZodotResult:
	if _coerce and typeof(value) == TYPE_STRING:
		value = str_to_var(value)
		
	if _nullable and value == null:
		return ZodotResult.good(value)
	
	if not _valid_type(value):
		return ZodotResult.type_error(field)
		
	if _kind == Kind.ONLY_TRUE and value != true:
		return ZodotResult.constraint_error(field, "Value must be only be true")
		
	if _kind == Kind.ONLY_FALSE and value != false:
		return ZodotResult.constraint_error(field, "Value must be only be false")
		
	return ZodotResult.good(value)
