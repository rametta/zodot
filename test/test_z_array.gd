extends GutTest

func test_z_array_base():
	assert_true(Z.array().parse([1,2,3]).is_ok())
	assert_true(Z.array().parse(["a"]).is_ok())
	assert_false(Z.array().parse(123).is_ok())
	assert_false(Z.array().parse(null).is_ok())
	assert_false(Z.array().parse("123").is_ok())
	
	var result = Z.array().parse("", "root")
	assert_false(result.is_ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'root' does not match desired type")

func test_z_array_non_empty():
	assert_true(Z.array().non_empty().parse([1,2]).is_ok())
	assert_false(Z.array().non_empty().parse([]).is_ok())
	
func test_z_array_nullable():
	assert_true(Z.array().nullable().parse([]).is_ok())
	assert_true(Z.array().nullable().parse(null).is_ok())

func test_z_array_coerce():
	var schema = Z.array().coerce()
	var data = var_to_str([1, 2, 3])
	var result = schema.parse(data)
	assert_true(result.is_ok())
	assert_eq(result.data, [1,2,3])
	
func test_z_array_schema_int():
	var schema = Z.array(Z.integer())
	assert_true(schema.parse([1, 2, 3]).is_ok())
	var result = schema.parse(["1", 2, 3], "my_arr")
	assert_false(result.is_ok())
	assert_null(result.data)
	assert_eq(result.error, "Field 'my_arr[0]' does not match desired type")
