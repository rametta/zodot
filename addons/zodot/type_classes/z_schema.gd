class_name z_schema extends Zodot

var _schema: Dictionary

# schema: Dictionary<string, Zodot>
func _init(schema: Dictionary):
	_schema = schema

func parse(value: Variant, field: String = "") -> ZodotResult:
	for _field in _schema:
		var field_name = _field
		if field:
			field_name = "{field1}.{field2}".format({ "field1": field, "field2": _field })
		var validator: Zodot = _schema[_field]
		var result: ZodotResult = validator.parse(value[_field], field_name)
		if not result.is_ok():
			return result
		
	return ZodotResult.ok(value)
