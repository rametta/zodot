class_name ZodotResult

enum Result {
	Ok, ## Value is valid
	TypeError, ## Value does not match desired type
	ConstraintError, ## Value does not satisfy constraint
	Unknown ## Not parsed yet
}

var value: Result = Result.Unknown
var error: String = ""
var data: Variant

func ok() -> bool:
	return value == Result.Ok

static func good(data: Variant) -> ZodotResult:
	var result = ZodotResult.new()
	result.value = Result.Ok
	result.data = data
	return result

static func type_error(field: String) -> ZodotResult:
	var result = ZodotResult.new()
	result.value = Result.TypeError
	result.error = "Field '{field}' does not match desired type".format({ "field": field })
	return result
	
static func constraint_error(field: String, detail: String = "") -> ZodotResult:
	var result = ZodotResult.new()
	result.value = Result.ConstraintError
	result.error = "Field '{field}' does not satisfy constraint. {detail}".format({ "field": field, "detail": detail })
	return result
