class_name z_dictionary extends Zodot

var _schema: Zodot
var _non_empty = false

func _init(schema = null):
	_schema = schema

func _valid_type(value: Variant) -> bool:
	return typeof(value) == TYPE_DICTIONARY
	
func non_empty() -> z_dictionary:
	_non_empty = true
	return self

func parse(value: Variant, field: String = "") -> ZodotResult:
	if _coerce and typeof(value) == TYPE_STRING:
		value = str_to_var(value)
		
	if _nullable and value == null:
		return ZodotResult.good(value)
	
	if not _valid_type(value):
		return ZodotResult.type_error(field)
		
	if _non_empty and value.is_empty():
		return ZodotResult.constraint_error(field, "Dictionary must not be empty")
		
	if _schema != null:
		for key in value:
			var result = _schema.parse(value[key], field + "[{key}]".format({ "key": key }))
			if not result.ok():
				return result
		
	return ZodotResult.good(value)
