extends GutTest

func test_z_boolean_base():
	assert_true(Z.boolean().parse(true).is_ok())
	assert_true(Z.boolean().parse(false).is_ok())
	assert_false(Z.boolean().parse(123).is_ok())
	assert_false(Z.boolean().parse(null).is_ok())
	assert_false(Z.boolean().parse("123").is_ok())
	assert_false(Z.boolean().parse("true").is_ok())
	assert_false(Z.boolean().parse("false").is_ok())
	
	var result = Z.boolean().parse("true", "root")
	assert_false(result.is_ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")

func test_z_boolean_nullable():
	assert_true(Z.boolean().nullable().parse(true).is_ok())
	assert_true(Z.boolean().nullable().parse(false).is_ok())
	assert_true(Z.boolean().nullable().parse(null).is_ok())

func test_z_boolean_coerce():
	var schema = Z.boolean().coerce()
	assert_true(schema.parse(var_to_str(true)).is_ok())
	assert_true(schema.parse(var_to_str(false)).is_ok())
	assert_true(schema.parse("true").is_ok())
	assert_true(schema.parse("false").is_ok())
	assert_false(schema.parse(null).is_ok())
	
	var result = schema.parse("true")
	assert_true(result.is_ok())
	assert_true(result.data == true)
	
	var result2 = schema.parse("false")
	assert_true(result2.is_ok())
	assert_true(result2.data == false)
	
func test_z_boolean_only_true():
	var schema = Z.boolean(z_boolean.Kind.ONLY_TRUE)
	assert_true(schema.parse(true).is_ok())
	assert_false(schema.parse(false).is_ok())
	
func test_z_boolean_only_false():
	var schema = Z.boolean(z_boolean.Kind.ONLY_FALSE)
	assert_true(schema.parse(false).is_ok())
	assert_false(schema.parse(true).is_ok())
