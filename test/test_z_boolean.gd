extends GutTest

func test_z_boolean_base():
	assert_true(Z.boolean().parse(true).ok())
	assert_true(Z.boolean().parse(false).ok())
	assert_false(Z.boolean().parse(123).ok())
	assert_false(Z.boolean().parse(null).ok())
	assert_false(Z.boolean().parse("123").ok())
	assert_false(Z.boolean().parse("true").ok())
	assert_false(Z.boolean().parse("false").ok())
	
	var result = Z.boolean().parse("true", "root")
	assert_false(result.ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")

func test_z_boolean_nullable():
	assert_true(Z.boolean().nullable().parse(true).ok())
	assert_true(Z.boolean().nullable().parse(false).ok())
	assert_true(Z.boolean().nullable().parse(null).ok())

func test_z_boolean_coerce():
	var schema = Z.boolean().coerce()
	assert_true(schema.parse(var_to_str(true)).ok())
	assert_true(schema.parse(var_to_str(false)).ok())
	assert_true(schema.parse("true").ok())
	assert_true(schema.parse("false").ok())
	assert_false(schema.parse(null).ok())
	
	var result = schema.parse("true")
	assert_true(result.ok())
	assert_true(result.data == true)
	
	var result2 = schema.parse("false")
	assert_true(result2.ok())
	assert_true(result2.data == false)
	
func test_z_boolean_only_true():
	var schema = Z.boolean(z_boolean.Kind.ONLY_TRUE)
	assert_true(schema.parse(true).ok())
	assert_false(schema.parse(false).ok())
	
func test_z_boolean_only_false():
	var schema = Z.boolean(z_boolean.Kind.ONLY_FALSE)
	assert_true(schema.parse(false).ok())
	assert_false(schema.parse(true).ok())
