class_name ZodotResult

enum Result {
	Ok, ## Value is valid
	TypeError, ## Value does not match desired type
	EmptyError, ## Value is empty
	MinError, ## Value is lower than min constraint
	MaxError, ## Value is higher than max constraint
	Unknown ## Not parsed yet
}

var value: Result = Result.Unknown
var error: String = ""

func is_ok() -> bool:
	return value == Result.Ok

static func ok() -> ZodotResult:
	var result = ZodotResult.new()
	result.value = Result.Ok
	return result

static func type_error(field: String) -> ZodotResult:
	var result = ZodotResult.new()
	result.value = Result.TypeError
	result.error = "Field '{field}' does not match desired type".format({ "field": field })
	return result
	
static func empty_error(field: String) -> ZodotResult:
	var result = ZodotResult.new()
	result.value = Result.EmptyError
	result.error = "Field '{field}' is empty".format({ "field": field })
	return result
	
static func min_error(field: String) -> ZodotResult:
	var result = ZodotResult.new()
	result.value = Result.MinError
	result.error = "Field '{field}' has value lower than desired minimum".format({ "field": field })
	return result

static func max_error(field: String) -> ZodotResult:
	var result = ZodotResult.new()
	result.value = Result.MaxError
	result.error = "Field '{field}' has value higher than desired maximum".format({ "field": field })
	return result
