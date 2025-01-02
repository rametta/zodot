class_name z_union extends Zodot

var _schemas: Array[Zodot] = []

func _init(schemas: Array[Zodot]):
	_schemas = schemas

func parse(value: Variant, field: Variant = "") -> ZodotResult:
	if _nullable and value == null:
		return ZodotResult.good(value)
		
	for schema in _schemas:
		var result = schema.parse(value)
		if result.ok():
			return result
		
	return ZodotResult.constraint_error(field, "Value does not satisfy any schemas in union")
