class_name z_schema extends Zodot

var _schema: Dictionary

# schema: Dictionary<string, Zodot>
func _init(schema: Dictionary):
	_schema = schema

func parse(value: Variant, field: Variant = "") -> ZodotResult:
	if _coerce and typeof(value) == TYPE_STRING:
		value = str_to_var(value)
		
	if _nullable and value == null:
		return ZodotResult.good(value)
		
	if not _nullable and value == null:
		return ZodotResult.constraint_error(field, "Missing dictionary")
		
	for _field in _schema:
		var field_name = _field
		if field:
			field_name = "{field1}.{field2}".format({ "field1": field, "field2": _field })
		
		var field_validator: Zodot = _schema[_field]
		
		if not field_validator._nullable and not value.has(_field):
			return ZodotResult.constraint_error(field_name, "Dictionary missing key")
			
		if not value.has(_field) and field_validator._nullable:
			continue
			
		var result: ZodotResult = field_validator.parse(value[_field], field_name)
		if not result.ok():
			return result
			
		value[_field] = result.data
		
	return ZodotResult.good(value)
