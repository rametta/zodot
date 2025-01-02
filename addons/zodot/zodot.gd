class_name Zodot

var _coerce = false
var _nullable = false

func _valid_type(_value: Variant) -> bool:
	# Implemented in subclass
	return false

func parse(_value: Variant, _field: Variant = "") -> ZodotResult:
	# Implemented in subclass
	return null
	
func coerce() -> Zodot:
	_coerce = true
	return self

func nullable() -> Zodot:
	_nullable = true
	return self
